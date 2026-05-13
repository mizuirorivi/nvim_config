require('template').setup({
  temp_dir = vim.fn.expand("~/.config/nvim/templates"),       -- template directory
  project_temp_dir = vim.fn.expand("~/.config/nvim/templates"), -- project template directory
  author = "mizuiro_rivi",                     -- your name
  email = "onodaha@gmail.com",                 -- email address
})
_G.template_persistent_vars = {}
vim.g.is_project_template = true
function get_or_set_persistent_var(var_name)
    if _G.template_persistent_vars[var_name] then
        return _G.template_persistent_vars[var_name]
    else
        local value = vim.fn.input(var_name .. ": ")
        _G.template_persistent_vars[var_name] = value
        return value
    end
end

require('template').register('{{_variableA_}}', function()
    return get_or_set_persistent_var('variableA')
end)

