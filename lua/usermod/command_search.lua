
local telescope = require('telescope')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')

local function search_which_key()
  -- which-keyに登録されているキーマッピングを取得
  local wk = require("which-key")
  local mappings = wk.get_mappings()
  local items = {}

  for _, mapping in pairs(mappings) do
    for key, opts in pairs(mapping) do
      local desc = opts.desc or "<N/A>"
      table.insert(items, {
        display = key .. " -> " .. desc,
        value = key,
        ordinal = key .. " " .. desc
      })
    end
  end

  -- Telescopeピッカーの設定
  pickers.new({}, {
    prompt_title = "Which-Key Mappings",
    finder = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.ordinal
        }
      end
    },
    sorter = sorters.get_generic_fuzzy_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(selection.value, true, false, true), 'n', true)
      end)
      return true
    end
  }):find()
end

-- SearchWhichKeyコマンドを作成
vim.api.nvim_create_user_command('SearchWhichKey', function()
  search_which_key()
end, {})

-- キーバインド
vim.api.nvim_set_keymap('n', '<leader>fc', ':SearchWhichKey<CR>', { noremap = true, silent = true })
