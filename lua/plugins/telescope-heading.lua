require('telescope').load_extension('heading')

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'markdown',
    'rst',
  },
})

local telescope = require('telescope')
telescope.setup({
  extensions = {
    heading = {
      treesitter = true,
    },
  },
})


telescope.load_extension('heading')


vim.api.nvim_create_user_command("MarkdownHeading", function()
  require('telescope').extensions.heading.heading()
end, { desc = "Show Window about Markdown Heading list by telescope" })

