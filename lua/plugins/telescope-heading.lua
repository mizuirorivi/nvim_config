local telescope = require('telescope')
telescope.setup({
  extensions = {
    heading = {
      treesitter = true,
    },
  },
})


pcall(telescope.load_extension, 'heading')


vim.api.nvim_create_user_command("MarkdownHeading", function()
  require('telescope').extensions.heading.heading()
end, { desc = "Show Window about Markdown Heading list by telescope" })

