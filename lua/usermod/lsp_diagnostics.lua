
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
telescope.load_extension('ui-select')
local builtin = require('telescope.builtin')


local function copy_title(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  if selection then
    local title = selection.text or selection.value
    vim.fn.setreg('+', title)
    vim.fn.setreg('"', title)
    print("Copied: " .. title)
  end
  actions.close(prompt_bufnr)
end

local M = {}
M.diagnostics = function(opts)
  opts = opts or {}
    builtin.diagnostics({
    bufnr = 0,
    severity = vim.diagnostic.severity.ERROR,
    attach_mappings = function(_,map)
      map('i', '<C-c>', copy_title)
      map('n', '<C-c>', copy_title)
      return true
    end
  })
end
M.global_diagnostics = function(opts)
  opts = opts or {}
  builtin.diagnostics({
    severity = vim.diagnostic.severity.ERROR,
    attach_mappings = function(_,map)
      map('i', '<C-c>', copy_title)
      map('n', '<C-c>', copy_title)
      return true
    end
  })

end
return M
