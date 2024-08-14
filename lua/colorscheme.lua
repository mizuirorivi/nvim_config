-- vim.o.background = "light" -- or "light" for light mode
-- Default options:
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
    SignColumn = {bg = "#d6deeb"}
  },
  dim_inactive = false,
  transparent_mode = false,
})
require("themery").setup({
  themes = {{
    name = "Gruvbox dark",
    colorscheme = "gruvbox",
    before = [[
      -- All this block will be executed before apply "set colorscheme"
      vim.opt.background = "dark"
    ]],
  },
  {
    name = "Gruvbox light",
    colorscheme = "gruvbox",
    before = [[
      vim.opt.background = "light"
    ]],
    after = [[-- Same as before, but after if you need it]]
  }},
})
