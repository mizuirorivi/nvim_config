
-- lua/your/null-ls/config.lua
local null_ls = require("null-ls")

-- Set up the sources you want to use with null-ls
local sources = {
    null_ls.builtins.formatting.prettier, -- Example: Prettier for formatting
    null_ls.builtins.diagnostics.eslint,  -- Example: ESLint for diagnostics
    -- Add more builtins as per your needs
}

null_ls.setup({
    sources = sources,
    -- You can add more configuration options here
    on_attach = function(client)
        -- Optional: Add on_attach configuration here if needed
    end,
})
