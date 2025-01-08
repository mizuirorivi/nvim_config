local Log = require("usermod.mynotify").new("ROOTER", vim.log.levels.INFO)
local bst = require("lib.bst")

local M = {}

M.rootmap = {}
M.rooter_pattern = {'.git/','Makefile','_darcs','.bzr','.svn','node_modules','CMakeLists.txt','.root'}
M.isautosave = true
M.savefile = '~/.rooter'

---@return table
function M:new()
  rooter = rooter or {}
  self.__index = self
  return setmetatable(rooter,self)
end
---@return string
function M:FindClosedRoot()
  local root = vim.fn.expand('%:p:h')
  Log:onlysave(root)

  while root ~= '' do
    Log:onlysave(root)
    for _, pattern in ipairs(self.rooter_pattern) do
      if pattern:sub(-1) == '/' then
        if vim.fn.isdirectory(root .. '/' .. pattern) == 2 then
          return root
        end
      end
      if vim.fn.findfile(pattern, root .. '/') ~= '' then
        return root
      end
    end
    if root == '/' then 
      break
    end
    
    root = vim.fn.fnamemodify(root, ':h')
  end
  return ''
end
return M

