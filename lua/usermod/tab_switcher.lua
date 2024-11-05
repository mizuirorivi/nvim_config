local M = {}

-- タブ一覧を取得して、選択したタブに移動
function M.switch_tab()
  -- すべてのタブページを取得
  local tabs = vim.api.nvim_list_tabpages()

  -- タブ番号とウィンドウ名をペアにしたリストを作成
  local tab_list = {}
  for _, tab in ipairs(tabs) do
    local tabnr = vim.api.nvim_tabpage_get_number(tab)
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
    local display_name = string.format('Tab %d: %s', tabnr, buf_name)
    table.insert(tab_list, { tabnr = tabnr, label = display_name })
  end
  require('fzf-lua').fzf_exec(
    vim.tbl_map(function(item) return item.label end, tab_list), 
    {
      prompt = 'Select Tab> ',
      actions = {
        ['default'] = function(selected)
          for _, item in ipairs(tab_list) do
            if item.label == selected[1] then
              vim.cmd('tabn ' .. item.tabnr)
              break
            end
          end
        end
      }
    }
  )
end

return M
