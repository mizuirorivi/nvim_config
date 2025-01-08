-- bst.lua
-- This module defines a simple Binary Search Tree (BST) structure for Lua.
-- Each node stores a value (which can be a table), and a "valuepattern" key
-- to determine how comparisons are made between nodes.

local BST = {}
BST.__index = BST

local Node = {}
Node.__index = Node

-- Node Constructor
-- @param value A table or any value to store in the node.
-- @param valuepattern A string representing the key in 'value' used for comparison.
function Node:new(value, valuepattern)
  -- Create a new node object with given value and comparison pattern.
  local obj = {
    value = value,           -- The stored value (table or other type)
    valuepattern = valuepattern, -- The key in 'value' used for comparisons
    left = nil,              -- Left child node
    right = nil              -- Right child node
  }
  setmetatable(obj, Node)
  return obj
end

-- This helper function checks if two values are "the same" by comparing
-- the specified pattern key in their value tables.
-- @param val1 First value table
-- @param val2 Second value table
-- @param pattern The key used for comparison
-- @return boolean True if the values match, false otherwise
local function is_same_value(val1, val2, pattern)
  return val1[pattern] == val2[pattern]
end

-- Insert a new value into the subtree rooted at this node, maintaining BST properties.
-- This function also attempts to handle "duplicate" entries by inserting them
-- to the right subtree if they differ in any field other than the comparison key.
-- @param val The new value to insert
function Node:insert(val)
  -- Extract the comparison keys from both the current node's value and the new value
  local currentKey = self.value[self.valuepattern]
  local newKey = val[self.valuepattern]

  -- If newKey is less than currentKey, it should go to the left subtree
  if newKey < currentKey then
    if self.left == nil then
      -- If there's no left child, create one
      self.left = Node:new(val, self.valuepattern)
    else
      -- Otherwise, recursively insert into the left subtree
      self.left:insert(val)
    end
  elseif newKey > currentKey then
    -- If newKey is greater than currentKey, it should go to the right subtree
    if self.right == nil then
      -- If there's no right child, create one
      self.right = Node:new(val, self.valuepattern)
    else
      -- Otherwise, recursively insert into the right subtree
      self.right:insert(val)
    end
  else
    -- If newKey == currentKey, we check if the entire value is identical.
    -- If the values differ in any field, we insert this "duplicate" on the right subtree.
    for k, v in pairs(val) do
      if self.value[k] ~= v then
        -- If we find any difference, insert into the right subtree
        if self.right == nil then
          self.right = Node:new(val, self.valuepattern)
        else
          self.right:insert(val)
        end
        return
      end
    end
    -- If no difference was found, it means it's truly identical,
    -- so we do nothing to avoid exact duplicates.
  end
end

-- Perform an in-order traversal of the subtree and collect values in an array.
-- In-order traversal: left subtree -> current node -> right subtree
-- @param result An optional table to accumulate results
-- @return A table containing all values in sorted order according to the valuepattern
function Node:inorder(result)
  result = result or {}
  -- Traverse the left subtree first
  if self.left then
    self.left:inorder(result)
  end
  -- Visit the current node
  table.insert(result, self.value)
  -- Finally, traverse the right subtree
  if self.right then
    self.right:inorder(result)
  end
  return result
end

-- BST Constructor
-- @param arr An optional initial array of values (tables) to insert into the BST
-- @param valuepattern The key in each value used for comparison
function BST:new(arr, valuepattern)
  -- Create a BST object with an optional array of initial values
  local obj = {
    root = nil,           -- The root node of the BST
    valuepattern = valuepattern -- The key used to compare node values
  }
  setmetatable(obj, BST)

  -- If an initial array is provided, create the root node and insert the rest
  if arr and #arr > 0 then
    obj.root = Node:new(arr[1], valuepattern)
    for i = 2, #arr do
      obj.root:insert(arr[i])
    end
  end

  return obj
end

-- Insert a new value into the BST.
-- If the BST is empty, the new value becomes the root.
-- If a value with the same pattern key already exists, this logic attempts
-- to handle duplicates by placing them on the right subtree if necessary.
-- @param val The new value to insert
function BST:insert(val)
  if self.root == nil then
    -- If there's no root, create one
    self.root = Node:new(val, self.valuepattern)
  else
    -- Otherwise, insert into the tree starting from the root
    self.root:insert(val)
  end
end

-- Return the BST elements as a sorted array (in-order traversal).
-- @return A table of all values sorted by the BST property
function BST:to_array()
  if self.root then
    return self.root:inorder()
  else
    return {}
  end
end

-- Example usage (commented out):
--[[
local arr = {
  { name = "Alice",   age = 30 },
  { name = "Bob",     age = 25 },
  { name = "Charlie", age = 35 },
  { name = "Dave",    age = 20 },
}

-- Create a BST from arr using "name" as the comparison key
local bst = BST:new(arr, "name")

-- Insert a new value with the same key but different data
bst:insert({ name = "Dave", age = 200 })

-- Convert the BST back to a sorted array and print the results
local sorted_arr = bst:to_array()

for _, v in ipairs(sorted_arr) do
  print(v.name, v.age)
end
]]

return BST
