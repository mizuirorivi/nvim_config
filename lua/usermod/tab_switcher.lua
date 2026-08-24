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
    local raw = vim.api.nvim_buf_get_name(buf)
    local buf_name = raw ~= '' and (vim.fn.fnamemodify(raw, ':h:t') .. '/' .. vim.fn.fnamemodify(raw, ':t')) or '[No Name]'
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

-- タブ一覧をユニーク化する（同じファイルを開いている重複タブを閉じる）
-- 閉じる前に、そのタブ内に未保存の変更があればセーブしてから閉じる（最低限の整合性）。
-- 名前無し／特殊バッファに未保存変更がある場合はセーブできないため、そのタブは残す。
function M.unique_tabs()
  local seen = {}
  local to_close = {}

  -- タブは主ウィンドウのバッファ名（フルパス）で識別する
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name ~= '' then
      if seen[name] then
        table.insert(to_close, tab)
      else
        seen[name] = true
      end
    end
    -- name == '' ([No Name]) は中身が別物の可能性があるので重複扱いしない
  end

  if #to_close == 0 then
    vim.notify('No duplicate tabs', vim.log.levels.INFO)
    return
  end

  local closed = 0
  local kept = 0
  for _, tab in ipairs(to_close) do
    if vim.api.nvim_tabpage_is_valid(tab) then
      -- このタブ内の未保存バッファをセーブ（保存できないものがあればタブを残す）
      local savable = true
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
        local b = vim.api.nvim_win_get_buf(w)
        if vim.bo[b].modified then
          local bname = vim.api.nvim_buf_get_name(b)
          if bname ~= '' and vim.bo[b].buftype == '' then
            local ok = pcall(function()
              vim.api.nvim_buf_call(b, function() vim.cmd('write') end)
            end)
            if not ok then savable = false end
          else
            -- 名前無し／特殊バッファは安全にセーブできない
            savable = false
          end
        end
      end

      if savable then
        vim.api.nvim_set_current_tabpage(tab)
        vim.cmd('tabclose')
        closed = closed + 1
      else
        kept = kept + 1
      end
    end
  end

  local msg = string.format('Unique tabs: closed %d duplicate(s)', closed)
  if kept > 0 then
    msg = msg .. string.format(', kept %d with unsavable changes', kept)
  end
  vim.notify(msg, vim.log.levels.INFO)
end

return M
