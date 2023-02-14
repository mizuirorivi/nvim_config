local nvim = vim.api
nvim.nvim_set_keymap("n","<Leader>gd",":LspDefinition",{silent=true})
