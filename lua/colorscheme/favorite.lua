
-- カラースキームの基本設定
local M = {}

-- デフォルトのカラーパレット
local colors = {
  bg = "#282828",
  fg = "#ebdbb2",
  red = "#fb4934",
  green = "#b8bb26",
  yellow = "#fabd2f",
  blue = "#83a598",
  purple = "#d3869b",
  aqua = "#8ec07c",
  orange = "#fe8019",
}

-- ハイライトグループの設定関数
function M.setup()
  -- 基本のハイライトグループ
  vim.api.nvim_set_hl(0, "Normal", { bg = colors.bg, fg = colors.fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = colors.green, italic = true })
  vim.api.nvim_set_hl(0, "String", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Function", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "Keyword", { fg = colors.purple, bold = true })
  vim.api.nvim_set_hl(0, "Error", { fg = colors.red, bold = true })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.orange, bold = true })

  -- 必要に応じて他のハイライトグループを追加
end

-- カラースキームの適用
M.setup()

return M
