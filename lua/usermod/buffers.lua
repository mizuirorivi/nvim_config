local function delete_no_name_buffers()
  local deleted = 0

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local is_no_name = vim.api.nvim_buf_get_name(bufnr) == ""
    local is_normal_buffer = vim.bo[bufnr].buftype == ""

    if vim.fn.buflisted(bufnr) == 1
        and is_no_name
        and is_normal_buffer then
      vim.api.nvim_buf_delete(bufnr, { force = true })
      deleted = deleted + 1
    end
  end

  vim.notify(string.format("Deleted %d no-name buffer(s)", deleted))
end

vim.api.nvim_create_user_command("DeleteNoNameBuffers", delete_no_name_buffers, {
  desc = "Delete all no-name buffers",
})
