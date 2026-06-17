if vim.loop.os_uname().sysname == "Linux" then
  vim.api.nvim_create_user_command("PasteImage", function()
    -- 現在のバッファのファイルがあるディレクトリを基準にする
    local bufpath = vim.api.nvim_buf_get_name(0)
    local basedir = bufpath ~= "" and vim.fn.fnamemodify(bufpath, ":p:h") or vim.fn.getcwd()

    local dir = basedir .. "/images"
    vim.fn.mkdir(dir, "p")

    local filename = os.date("%Y%m%d_%H%M%S") .. ".png"
    local fullpath = dir .. "/" .. filename
    -- マークダウンにはバッファからの相対パスで埋め込む
    local path = "images/" .. filename

    local cmd = string.format(
      "xclip -selection clipboard -t image/png -o > %s",
      vim.fn.shellescape(fullpath)
    )

    local output = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
      vim.notify("failed to save clipboard image: " .. output, vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_put({ "![](" .. path .. ")" }, "l", true, true)
  end, {
    desc = "Paste clipboard image as markdown image",
  })
end
