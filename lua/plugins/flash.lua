local function flash_search_mode(str)
  if str == nil or str == "" then
    return str
  end

  -- 大文字を含むなら、SMAP / HTTP / JSON などの英字検索として扱う
  if str:find("%u") then
    return "\\V" .. vim.fn.escape(str, "\\")
  end

  -- 数字・記号を含む検索も、そのまま検索として扱う
  -- 例: H2O, foo_bar, test-01 など
  if str:find("[%d%p]") then
    return "\\V" .. vim.fn.escape(str, "\\")
  end

  -- 日本語を直接入力した場合も、そのまま検索
  -- Lua pattern の ASCII 範囲外を雑に検出
  if str:find("[^%z\1-\127]") then
    return "\\V" .. vim.fn.escape(str, "\\")
  end

  -- 小文字ローマ字だけ kensaku に渡す
  return vim.fn["kensaku#query"](str)
end

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump({ search = { mode = flash_search_mode } })
end, { desc = "Flash Kensaku" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
