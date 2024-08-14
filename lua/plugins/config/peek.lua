local function is_i3wm_installed()
    local handle = io.popen("i3 --version")
    local result = handle:read("*a")
    handle:close()
    return result:match("i3 version") ~= nil
end

-- default config:
local M = {
  auto_load = true,         -- whether to automatically load preview when
                            -- entering another markdown buffer
  close_on_bdelete = true,  -- close preview window on buffer delete

  syntax = true,            -- enable syntax highlighting, affects performance

  theme = 'dark',           -- 'dark' or 'light'

  update_on_change = true,

  app = 'webview',          -- 'webview', 'browser', string or a table of strings
                            -- explained below

  filetype = { 'markdown' },-- list of filetypes to recognize as markdown

  -- relevant if update_on_change is true
  throttle_at = 200000,     -- start throttling when file exceeds this
                            -- amount of bytes in size
  throttle_time = 'auto',   -- minimum amount of time in milliseconds
                            -- that has to pass before starting new render
}



-- keymap for peekopen to ctrl + p
vim.api.nvim_set_keymap('n', 'C-s', ':PeekOpen<CR>', { noremap = true, silent = true })
-- keymap for peekclose to ctrl + p if PeekOpened
vim.api.nvim_set_keymap('n', 'C-p', ':PeekClose<CR>', { noremap = true, silent = true })
if is_i3wm_installed() then
    vim.api.nvim_create_user_command('PeekOpen', function()
        if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
            vim.fn.system('i3-msg split horizontal')
            peek.open()
        end
    end, {})
  vim.api.nvim_create_user_command('PeekClose', function()
    if peek.is_open() then
      peek.close()
      vim.fn.system('i3-msg move left')
    end
  end, {})
  else
    print("i3wm is not installed, PeekOpen command will not be available.")
end


