require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },

  redirect = {
    view = "split",
    filter = {
      event = "msg_show",
    },
  },

  commands = {
    history = {
      view = "split",
      opts = {
        enter = true,
        format = "details",
      },
      filter = {
        any = {
          { event = "msg_show" },
          { event = "notify" },
          { event = "lsp" },
        },
      },
    },
  },

  routes = {
    {
      filter = {
        event = "notify",
        any = {
          { find = "rustfmt" },
          { find = "which%-key" },
        },
      },
      opts = {
        skip = true,
      },
    },
  },
})

vim.keymap.set("c", "<M-CR>", function()
  require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect command output to Noice" })
