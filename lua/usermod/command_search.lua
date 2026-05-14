
local function search_commands()
  local entry_display = require('telescope.pickers.entry_display')
  local displayer = entry_display.create({
    separator = "▏",
    items = {
      { width = 28 },
      { width = 30 },
      { width = 4  },
      { width = 4  },
      { width = 11 },
      { remaining = true },
    },
  })

  require('telescope.builtin').commands({
    entry_maker = function(command)
      return {
        name       = command.name,
        bang       = command.bang,
        nargs      = command.nargs,
        complete   = command.complete,
        definition = command.definition,
        value      = command,
        ordinal    = command.name .. " " .. (command.desc or ""),
        display    = function(entry)
          return displayer({
            { entry.name,         "TelescopeResultsFunction" },
            { command.desc or "", "Comment"                  },
            entry.bang and "!" or "",
            entry.nargs,
            entry.complete or "",
            entry.definition,
          })
        end,
      }
    end,
  })
end

vim.api.nvim_create_user_command('SearchCommands', search_commands, { desc = "Search commands with descriptions" })
