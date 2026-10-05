-- Which-key + keymap search for the light profile.
--
-- The full profile uses plugins/which-key.lua, which also loads telescope
-- extensions (bookmarks / notify). Telescope is intentionally excluded from
-- the light profile, so this lightweight variant provides the space-triggered
-- menu and the keymap search using only plugins available here
-- (fzf-lua, toggleterm).

local M = {}

function M.setup()
  local wk = require("which-key")

  wk.setup({ triggers = { "<space>" } })

  local function search_keymaps()
    require("fzf-lua").keymaps()
  end

  -- `<leader>k` (space+k) and `\k` (localleader+k).
  vim.keymap.set("n", "<leader>k", search_keymaps, { desc = "Search Keymaps" })
  vim.keymap.set("n", "<localleader>k", search_keymaps, { desc = "Search Keymaps" })

  wk.add({
    { "<leader>k", desc = "Search Keymaps" },
    { "<localleader>k", desc = "Search Keymaps" },
    { "<leader>s", group = "Terminal" },
    { "<leader>ss", desc = "Toggle Terminal" },
    { "<leader>?", function() wk.show({}) end, desc = "Show Keymaps (which-key)" },
  })
end

return M
