local NotifyManager = require('usermod.mynotify').new()
local default_notify = NotifyManager

-- -- vim.notifyを置き換える
-- vim.notify = function(msg, level, opts)
--    default_notify:new({
--       options = {
--          title = opts.title,
--          level = level,
--          timeout = 10,
--       }
--    })
--   default_notify:onlysave(msg)
--   vim.api.notify_once(msg, level, opts)
-- end
