_G.saved_notifications = {}
local M = {}
M.__index = M

function M.new(title, level, setup_option, options)
  local self = setmetatable({}, M)
  self.level = level or vim.log.levels.INFO
  self.title = title or "Neovim CONFIG INFORMATION"
  self.options = options or {
    title = self.title,
    level = self.level,
    timeout = 0,
  }
  self.setup_option = setup_option or {
    minimum_width = 10,
    background_colour = "#000000",
    render = "wrapped-compact",
  }
  return self
end

function M:onlysave(message)
  table.insert(_G.saved_notifications, {
    message = message,
    level = self.level,
    title = self.title,
    time = os.time(),
    notify = self
  })
end
function M:my_notify(message)
  local status, notify = pcall(require, 'notify')
  if status then
    notify.setup(self.setup_option)
    notify(message, self.level, self.options)
    table.insert(_G.saved_notifications, {
      message = message,
      level = self.level,
      title = self.title,
      time = os.time(),
      notify = self
    })
  else
    vim.notify(message, self.level)
  end
end


function M.show_saved_notifications()
  
  vim.schedule(function()
    if #_G.saved_notifications == 0 then
      vim.notify("No saved notifications", vim.log.levels.INFO)
      return
    end
    
    _G.saved_notifications = sort_and_remove_duplicates(_G.saved_notifications)
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    pickers.new({}, {
      prompt_title = "Saved Notifications",
      finder = finders.new_table {
        results = _G.saved_notifications,
        entry_maker = function(entry)
          local title = tostring(entry.title or "")
          local message = tostring(entry.message or "")
          return {
            value = entry,
            display = title .. ": " .. message,
            ordinal = tostring(entry.time or 0) .. title .. ": " .. message,
          }
        end
      },
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection and selection.value then
            local notification = selection.value
            if notification.notify and notification.notify.my_notify then
              options = {
                title = notification.title,
                level = notification.level,
                timeout = 10,
              }
              notification.notify:new({
                options = options,
              })
              notification.notify:my_notify(notification.message)
            else
              vim.notify("Invalid notification entry", vim.log.levels.WARN)
            end
          end
        end)
        return true
      end,
    }):find()
  end)
end

function sort_and_remove_duplicates(notifications)
  table.sort(notifications, function(a, b)
    if a.message == b.message then
      return a.time > b.time 
    end
    return a.message < b.message
  end)

  local result = {}
  for i = 1, #notifications do
    if i == 1 or notifications[i].message ~= notifications[i-1].message then
      table.insert(result, notifications[i])
    end
  end

  return result
end

return M
