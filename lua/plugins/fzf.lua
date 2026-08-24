-- fzf config

-- 選択した候補を :tab drop で開く。
-- デフォルトの ctrl-t (file_tabedit) は候補1件ごとに必ず新規タブを作るため、
-- 同一ファイルの複数grepマッチや既に開いているファイルで重複タブが量産される。
-- :tab drop は既存のタブ/ウィンドウを再利用する。
local function tab_drop_selected(selected, opts)
  local fzf_path = require('fzf-lua.path')
  for i, sel in ipairs(selected) do
    local entry = fzf_path.entry_to_file(sel, opts)
    local fullpath = entry.bufname or entry.path
    if fullpath and fullpath ~= '' then
      if not fzf_path.is_absolute(fullpath) then
        fullpath = fzf_path.join({ opts.cwd or opts._cwd or vim.uv.cwd(), fullpath })
      end
      vim.cmd('tab drop ' .. vim.fn.fnameescape(fullpath))
      if entry.line and entry.line > 0 then
        pcall(vim.api.nvim_win_set_cursor, 0, { entry.line, math.max(0, (entry.col or 1) - 1) })
      end
      if i == #selected then
        vim.cmd('norm! zvzz')
      end
    end
  end
end

-- Ctrl-aで選択した候補をCtrl-iで次段へ送り、Ctrl-oで前段へ戻す。
-- fzf-luaのRPCを使うため、外部スクリプトやOS固有コマンドは不要。
local function staged_picker(picker, opts)
  local base_opts = vim.deepcopy(opts or {})
  local prepare_opts = vim.deepcopy(base_opts)
  prepare_opts._start = false

  local _, initial_cmd, picker_opts = picker(prepare_opts)
  if not initial_cmd or not picker_opts then
    return
  end

  local core = require('fzf-lua.core')
  local shell = require('fzf-lua.shell')
  local stack = {}
  local candidates
  local restored_query = ''

  local candidates_cmd = shell.stringify_data(function()
    return candidates or {}
  end, picker_opts)

  local query_cmd = shell.stringify_data(function()
    return restored_query
  end, picker_opts)

  local push_cmd = shell.stringify_data(function(items)
    local query = table.remove(items) or ''
    if query == '' or #items == 0 then
      return ''
    end

    stack[#stack + 1] = { candidates = candidates, query = query }
    candidates = items
    return ('reload(%s)+clear-query+deselect-all'):format(candidates_cmd)
  end, picker_opts, '{+} {q}')

  local pop_cmd = shell.stringify_data(function()
    local previous = table.remove(stack)
    if not previous then
      return ''
    end

    candidates = previous.candidates
    restored_query = previous.query
    local source_cmd = candidates and candidates_cmd or initial_cmd
    return ('reload(%s)+transform-query(%s)+deselect-all'):format(source_cmd, query_cmd)
  end, picker_opts)

  picker_opts.keymap.fzf['tab'] = ('transform(%s)'):format(push_cmd)
  picker_opts.keymap.fzf['ctrl-o'] = ('transform(%s)'):format(pop_cmd)
  picker_opts.__call_fn = function(call_opts)
    return staged_picker(picker, vim.tbl_deep_extend('force', vim.deepcopy(base_opts), call_opts or {}))
  end
  picker_opts._start = nil
  return core.fzf_wrap(initial_cmd, picker_opts)
end

-- <C-p> と <C-f> で共有する検索専用ルート。Neovim の cwd は変更しない。
local search_root

local function current_search_root()
  return search_root or vim.fn.getcwd()
end

local function change_search_root(_, opts)
  vim.schedule(function()
    vim.ui.input({
      prompt = 'Search root: ',
      default = opts.cwd or current_search_root(),
      completion = 'dir',
    }, function(input)
      if not input or vim.trim(input) == '' then
        return
      end

      local root = vim.fs.normalize(vim.fn.fnamemodify(vim.fn.expand(vim.trim(input)), ':p'))
      if vim.fn.isdirectory(root) ~= 1 then
        vim.notify(('Not a directory: %s'):format(root), vim.log.levels.WARN)
        return
      end

      search_root = root
      if type(opts.__call_fn) == 'function' then
        -- resume=true keeps the current grep/fzf query while regenerating candidates.
        opts.__call_fn({ cwd = root, resume = true })
      end
    end)
  end)
end

local change_root_action = {
  fn = change_search_root,
  desc = 'change-search-root',
  header = false,
}

local search_help_entries = {
  'C-p       Find files by name under the shared search root',
  'C-f       Search file contents under the shared search root',
  'Alt-d     Change the shared search root without changing pwd',
  'C-g       Resume the last picker and its query',
  '?         Open this searchable C-p / C-f help',
  'Ctrl-a    Toggle selection of all entries',
  'Ctrl-i    Use selected entries as the next fuzzy stage',
  'Ctrl-o    Return to the previous fuzzy stage',
  'Shift-tab Toggle selection of the current entry',
  'Enter     Open the selected entry',
  'Ctrl-t    Open selected entries in tabs, reusing existing tabs',
  'Ctrl-s    Open the selected entry in a horizontal split',
  'Ctrl-v    Open the selected entry in a vertical split',
  'F4        Toggle the preview',
}

local function show_search_help(_, source_opts)
  local function return_to_search()
    vim.schedule(function()
      if type(source_opts.__call_fn) == 'function' then
        source_opts.__call_fn({
          cwd = source_opts.cwd or current_search_root(),
          resume = true,
        })
      end
    end)
  end

  vim.schedule(function()
    require('fzf-lua').fzf_exec(search_help_entries, {
      prompt = 'Help> ',
      previewer = false,
      file_icons = false,
      no_resume = true,
      no_hide = true,
      winopts = {
        title = 'C-P / C-F Help | type to fuzzy search | Enter/Esc: back',
        title_flags = false,
      },
      actions = {
        default = { fn = return_to_search, desc = 'return-to-search' },
        esc = { fn = return_to_search, desc = 'return-to-search' },
      },
    })
  end)
end

local search_help_action = {
  fn = show_search_help,
  desc = 'search-help',
  header = false,
}

require('fzf-lua').setup({
  keymap = {
    fzf = {
      true, -- デフォルトバインド(F4プレビュー切替, ctrl-f/bページ送り等)を継承
      -- 絞り込んだ候補を全選択/解除（Ctrl-Iで次段、Ctrl-Tでタブに開く）
      ["ctrl-a"] = "toggle-all",
    },
  },
  fzf_opts = {
    -- 選択済み候補のマーカー（選択数は右上infoの "(N)" にも出る）
    ["--marker"] = "✓ ",
  },
  fzf_colors = {
    true, -- カラースキーム連動を維持
    ["marker"] = { "fg", "DiagnosticOk", "bold" },
    -- 選択済み行は背景色で塗る（マーカーより一目でわかる）
    ["selected-bg"] = { "bg", "Visual" },
  },
  actions = {
    files = {
      true, -- デフォルトアクション(enter/ctrl-s/ctrl-v等)を継承
      -- ctrl-t: 選択候補をタブで開く（重複タブを作らない）
      ["ctrl-t"] = tab_drop_selected,
    },
  },
  files = {
    fd_opts = "--type f --hidden --follow --exclude .git --no-ignore",
    rg_opts = "--files --hidden --follow -g '!.git'",
    find_opts = "-type f",
    -- Add Makefile to the list of recognized file types
    file_ignore_patterns = {"^.git/", "^node_modules/", "^vendor/"},
    actions = {
      ["alt-d"] = change_root_action,
      ["?"] = search_help_action,
    },
  },
  grep = {
    actions = {
      ["alt-d"] = change_root_action,
      ["?"] = search_help_action,
    },
  },
})
--vim.cmd[[
-- nnoremap <c-P> <cmd>lua require('fzf-lua').files({prompt="LS> ",cwd=vim.fn.getcwd()})<CR>
-- nnoremap <c-F> <cmd>lua require('fzf-lua').grep()<CR>
--]]

-- function _G.fzf_file()
--   if vim.g.pwd == nil then
--     tabbylog:onlysave('vim.g.pwd is nil and cwd is ' .. vim.fn.getcwd())
--     vim.g.pwd = vim.fn.getcwd()
--   else
--     tabbylog:onlysave('vim.g.pwd is ' .. vim.g.pwd)
--   end

--   vim.api.nvim_set_current_dir(vim.g.pwd)
-- end

vim.keymap.set('n', '<C-P>', function()
  staged_picker(require('fzf-lua').files, {
    prompt = 'Files> ',
    cwd = current_search_root(),
    winopts = {
      title = 'Files | ? | h | Alt-D',
      title_flags = false,
    },
  })
end, { silent = true, desc = 'Find files in search root' })

vim.keymap.set('n', '<C-F>', function()
  staged_picker(require('fzf-lua').grep, {
    prompt = 'Grep> ',
    cwd = current_search_root(),
    winopts = {
      title = 'Grep | ? | Alt-D',
    },
  })
end, { silent = true, desc = 'Grep in search root' })
-- 直前の検索を続きから再開（picker種別・rgパターン・fzf内クエリまで復元）
vim.api.nvim_set_keymap('n', '<C-G>', "<cmd>lua require('fzf-lua').resume()<CR>", { noremap = true, silent = true })
