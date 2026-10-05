
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.fn.has("win32") == 1 then
  -- Keep external commands compatible even when Neovim inherits PowerShell.
  vim.opt.shell = vim.env.COMSPEC or "cmd.exe"
  vim.opt.shellcmdflag = "/d /s /c"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

vim.cmd[[
  set termguicolors
  set undolevels=200
  set ffs=unix
  set encoding=utf-8
  set fileencoding=utf-8
  set listchars=eol:$
  set list
  nnoremap <leader>sv :source $MYVIMRC<CR>
]]

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.chdir(vim.fn.getcwd()) -- シェルのCWDを明示的に設定
  end,
})
-- desc を捕捉・注入するラッパー（プラグインより先に設定）
_G._cmd_descs = {}

local _orig_create_cmd = vim.api.nvim_create_user_command
vim.api.nvim_create_user_command = function(name, cmd, opts)
  if opts and opts.desc then
    _G._cmd_descs[name] = opts.desc
  end
  return _orig_create_cmd(name, cmd, opts)
end

local _orig_get_commands = vim.api.nvim_get_commands
vim.api.nvim_get_commands = function(opts)
  local result = _orig_get_commands(opts)
  for name, desc in pairs(_G._cmd_descs) do
    if result[name] then
      result[name].desc = desc
    end
  end
  return result
end

local _orig_buf_get_commands = vim.api.nvim_buf_get_commands
vim.api.nvim_buf_get_commands = function(buf, opts)
  local result = _orig_buf_get_commands(buf, opts)
  for name, desc in pairs(_G._cmd_descs) do
    if result[name] then
      result[name].desc = desc
    end
  end
  return result
end

-- vim.diagnostic.disable was removed in Neovim 0.10+; shim for plugins that still use it
if vim.diagnostic.disable == nil then
  vim.diagnostic.disable = function(bufnr, _ns)
    vim.diagnostic.enable(false, { bufnr = bufnr })
  end
end

-- Profile is resolved from $NVIM_PROFILE, then <config>/.profile, else "full".
-- The full branch keeps the original require order unchanged; only the light
-- branch and the profile lookup are new.
local profile = require('usermod.profile')

if profile.is_light then
  require('usermod.notify_intercept')
  require('usermod.light') -- bootstrap lazy.nvim with the minimal plugin set
  local requirePath = require("usermod.require_path").requirePath
  requirePath('user_config')
  requirePath('colorscheme')
  require('usermod.tab_switcher')
  require('usermod.split')
  require('usermod.buffers')
  require('usermod.pasteimage')
  require "colorscheme"
else
  require('usermod.notify_intercept')
  require('usermod.treesitter_fix')
  local requirePath = require("usermod.require_path").requirePath
  requirePath('config')
  requirePath('user_config')
  requirePath('plugins')
  requirePath('colorscheme')
  requirePath('plugins/language')
  require('usermod.command_search')
  require('usermod.tab_switcher')
  require('usermod.lsp_diagnostics')
  require('usermod.split')
  require('usermod.buffers')
  require('usermod.backup_files')
  require('usermod.pasteimage')
  require "colorscheme"
end

local python = ""
if vim.fn.has("win32") == 1 then
  local python_root = vim.fs.joinpath(vim.env.LOCALAPPDATA or "", "Programs", "Python")
  local candidates = vim.fn.glob(vim.fs.joinpath(python_root, "Python*", "python.exe"), true, true)
  table.sort(candidates, function(a, b)
    local a_version = tonumber(a:match("Python(%d+)[/\\]python%.exe$")) or 0
    local b_version = tonumber(b:match("Python(%d+)[/\\]python%.exe$")) or 0
    return a_version > b_version
  end)
  python = candidates[1] or ""
end
if python == "" then python = vim.fn.exepath("python3") end
if python == "" then python = vim.fn.exepath("python") end
if python ~= "" then
  vim.g.python3_host_prog = python
end

vim.cmd[[
  map <CS-c> "+y
  map <CS-v> "+p
]]
