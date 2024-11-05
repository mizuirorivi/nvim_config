vim.g.codeium_disable_bindings = 1

    -- Codeium mappings to match Copilot config
    vim.api.nvim_set_keymap('n', '<leader>cpe', ':CodeiumEnable<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cpd', ':CodeiumDisable<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cps', ':Codeium status<CR>', { noremap = true, silent = true })

    -- Accept suggestion (similar to `<C-j>` in Copilot config)
    vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })

    -- Optionally, set up additional mappings for cycling and clearing suggestions
    vim.keymap.set('i', '<C-;>', function() return vim.fn end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
