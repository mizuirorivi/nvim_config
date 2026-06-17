-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- hijack_directories が cwd を変える前にキャプチャ
local startup_dir = vim.fn.getcwd()

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  hijack_directories = {
    enable = true, auto_open = false,
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
  },
})

local function find_root(dir)
  local markers = { ".root", ".git", "package.json" }
  local current = dir
  while current and current ~= "/" do
    for _, marker in ipairs(markers) do
      if vim.fn.filereadable(current .. "/" .. marker) == 1
        or vim.fn.isdirectory(current .. "/" .. marker) == 1 then
        return current
      end
    end
    local parent = vim.fn.fnamemodify(current, ":h")
    if parent == current then break end
    current = parent
  end
  return nil
end

-- <C-b>: ツリーが開いていれば閉じる、閉じていれば現在ファイルのプロジェクトルートで開く
-- api.tree.find_file({ open = true }) はルートのズレを自動で修正するため、
-- cwd が ~/  に流れた後でも正しいプロジェクトルートに戻る
local function smart_tree_toggle()
  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then return end

  if api.tree.is_visible() then
    api.tree.close()
    return
  end

  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
    -- find_file はファイルがツリールート外にあればルートを自動変更する
    api.tree.find_file({ buf = current_buf, open = true })
  else
    api.tree.open()
  end
end

vim.keymap.set("n", "<C-b>", smart_tree_toggle, { noremap = true, silent = true })

-- vim . で起動したとき、一度だけ tree を startup_dir で開く
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local arg = vim.fn.argv(0)
    if arg == "" or vim.fn.isdirectory(arg) ~= 1 then return end
    local ok, api = pcall(require, "nvim-tree.api")
    if not ok then return end
    api.tree.open()
    vim.defer_fn(function()
      api.tree.change_root(startup_dir)
    end, 200)
  end,
})

-- ファイルバッファに入ったときにツリーのルートをプロジェクトルートに追従させる
-- (ツリーが開いている間だけ実行してルートのズレを防ぐ)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    if buftype ~= "" or bufname == "" or vim.fn.isdirectory(bufname) == 1 then
      return
    end
    vim.schedule(function()
      local ok, api = pcall(require, "nvim-tree.api")
      if not ok or not api.tree.is_visible() then return end
      local dir = vim.fn.fnamemodify(bufname, ":h")
      local root = find_root(dir)
      if root then
        api.tree.change_root(root)
      end
    end)
  end,
})
