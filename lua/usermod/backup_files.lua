local function backup_directories()
  local directories = {}

  for _, option in ipairs({ vim.opt.backupdir:get(), vim.opt.directory:get() }) do
    for _, directory in ipairs(option) do
      directory = vim.fn.expand(directory)
      if directory ~= "" and vim.fn.isdirectory(directory) == 1 then
        directories[directory] = true
      end
    end
  end

  return vim.tbl_keys(directories)
end

local function backup_files()
  local files = {}
  local seen = {}

  local function decode_target(path, kind)
    local name = vim.fn.fnamemodify(path, ":t")

    if kind == "swap" then
      name = name:gsub("%.sw.$", "")
    else
      name = name:gsub("~$", "")
    end

    if name:sub(1, 1) ~= "%" then
      if kind == "swap" then
        return path:gsub("%.sw.$", "")
      end
      return path:gsub("~$", "")
    end

    name = name:gsub("%%(%x%x)", function(hex)
      return string.char(tonumber(hex, 16))
    end)
    name = name:gsub("%%", "/")

    return name:sub(1, 1) == "/" and name or "/" .. name
  end

  local function add_file(path, kind)
    if vim.fn.filereadable(path) == 1 and not seen[path] then
      seen[path] = true
      table.insert(files, {
        value = path,
        kind = kind,
        target = decode_target(path, kind),
      })
    end
  end

  for _, directory in ipairs(backup_directories()) do
    for _, path in ipairs(vim.fn.globpath(directory, "**/*~", false, true)) do
      add_file(path, "backup")
    end
    for _, pattern in ipairs({ "**/*.sw?", "**/.?*.sw?" }) do
      for _, path in ipairs(vim.fn.globpath(directory, pattern, false, true)) do
        add_file(path, "swap")
      end
    end
  end

  table.sort(files, function(left, right)
    return left.value < right.value
  end)

  if #files == 0 then
    vim.notify("No backup or swap files found", vim.log.levels.INFO)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function restore_entry(entry)
    if entry.kind == "swap" then
      vim.cmd("recover " .. vim.fn.fnameescape(entry.target))
      return
    end

    local content = vim.fn.readfile(entry.value, "b")
    if vim.fn.writefile(content, entry.target, "b") ~= 0 then
      vim.notify("Could not restore: " .. entry.target, vim.log.levels.ERROR)
      return
    end

    if vim.fn.bufname(0) == entry.target then
      vim.cmd("edit!")
    end
    vim.notify("Restored: " .. entry.target)
  end

  local function restore_selected(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected = picker:get_multi_selection()
    local entry = selected[1] or action_state.get_selected_entry()

    if not entry then
      return
    end

    actions.close(prompt_bufnr)
    restore_entry(entry)
  end

  local function delete_selected(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected = picker:get_multi_selection()

    if #selected == 0 then
      local current = action_state.get_selected_entry()
      if current then
        table.insert(selected, current)
      end
    end

    actions.close(prompt_bufnr)

    local deleted = 0
    for _, entry in ipairs(selected) do
      if vim.fn.delete(entry.value) == 0 then
        deleted = deleted + 1
      end
    end

    vim.notify(string.format("Deleted %d backup/swap file(s)", deleted))
  end

  pickers.new({}, {
    prompt_title = "Backup Files | C-r/r: restore | C-d/d: delete | Tab: select",
    finder = finders.new_table({
      results = files,
      entry_maker = function(file)
        return {
          value = file.value,
          display = string.format("[%s] %s -> %s", file.kind, file.value, file.target),
          ordinal = file.value .. " " .. file.target,
          kind = file.kind,
          target = file.target,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<C-d>", delete_selected)
      map("n", "d", delete_selected)
      map("i", "<C-r>", restore_selected)
      map("n", "r", restore_selected)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("BackupFiles", backup_files, {
  desc = "List, restore, or delete backup and swap files",
})
