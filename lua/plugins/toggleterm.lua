require("toggleterm").setup{
  size = 13,
  open_mapping = [[<Leader>ss]],
  autochdir = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = 'float'
}

