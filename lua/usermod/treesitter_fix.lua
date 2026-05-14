-- Workaround: nvim-treesitter's set-lang-from-info-string! directive
-- calls node:range() without guarding against stale nodes in Neovim 0.12.
-- Re-register the directive with a nil-safe version.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    local ok, query = pcall(require, "vim.treesitter.query")
    if not ok then return end

    local non_filetype_aliases = {
      ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
    }
    local html_script_type_languages = {
      ["importmap"] = "json",
      ["module"] = "javascript",
      ["application/ecmascript"] = "javascript",
      ["text/ecmascript"] = "javascript",
    }
    local opts = { force = true, all = false }

    local function safe_get_node_text(node, bufnr)
      if not node or type(node.range) ~= "function" then return nil end
      local ok2, text = pcall(vim.treesitter.get_node_text, node, bufnr)
      return ok2 and text or nil
    end

    query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local node = match[pred[2]]
      local text = safe_get_node_text(node, bufnr)
      if not text then return end
      local alias = text:lower()
      local match2 = vim.filetype.match { filename = "a." .. alias }
      metadata["injection.language"] = match2 or non_filetype_aliases[alias] or alias
    end, opts)

    query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
      local node = match[pred[2]]
      local text = safe_get_node_text(node, bufnr)
      if not text then return end
      local configured = html_script_type_languages[text]
      if configured then
        metadata["injection.language"] = configured
      else
        local parts = vim.split(text, "/", {})
        metadata["injection.language"] = parts[#parts]
      end
    end, opts)
  end,
})
