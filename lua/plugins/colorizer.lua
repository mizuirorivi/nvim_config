require'colorizer'.setup({
  '*'; -- 全てのファイルタイプで有効化
}, {
  RGB = true;      -- #RGB形式
  RRGGBB = true;   -- #RRGGBB形式
  names = false;   -- "Blue"などのカラー名を無効化
  RRGGBBAA = true; -- #RRGGBBAA形式
  rgb_fn = true;   -- CSSのように `rgb()` 関数を有効化
  hsl_fn = true;   -- CSSのように `hsl()` 関数を有効化
})
