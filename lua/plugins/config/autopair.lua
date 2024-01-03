require('nvim-autopairs').setup({
    fast_wrap = {
      map = '<C-a>',  -- 使用するキーのマッピング
      chars = { '{', '[', '(', '"', "'" },  -- 囲むのに使う文字
      pattern = [=[[%'%"%>%]%)%}%,]]=],  -- パターンマッチングの設定
      end_key = '$',  -- 終了キー
      keys = 'qwertyuiopzxcvbnmasdfghjkl',  -- キーの設定
      highlight = 'Search',  -- ハイライトの色
      highlight_grey='Comment'  -- グレーのハイライトの色
    },
})
