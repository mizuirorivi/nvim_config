## structure
```
├── README.md
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config        -- full profile bootstrap (lazy.nvim spec)
│   ├── colorscheme
│   ├── plugins
│   └── usermod       -- profile resolver, light profile, helper modules
├── pack
├── setup.sh
└── templates
```

## profiles

This config ships two profiles:

- **full** (default): everything (LSP/mason, treesitter, telescope, cmp, AI plugins, ...).
- **light**: editing-focused minimal set for small machines (e.g. 8 GB RAM).
  fzf-lua, nvim-tree, autopairs, surround, undotree, gruvbox, airline.
  No LSP, treesitter, telescope, cmp, AI, denops.

### selecting a profile

Resolution order (all platforms, no shell-specific syntax needed):

1. `$NVIM_PROFILE` = `light` or `full`
2. `<config>/.profile` (first non-empty line = `light` or `full`) — git-ignored
3. default = `full`

```sh
# one-off
NVIM_PROFILE=light nvim          # bash / zsh
$env:NVIM_PROFILE="light"; nvim  # PowerShell
set NVIM_PROFILE=light && nvim   # cmd.exe

# per-machine default (Linux / macOS: ~/.config/nvim/.profile)
echo light > ~/.config/nvim/.profile
```

Check the active profile inside Neovim:

```vim
:Profile
```

Both profiles share the plugin install directory, so switching never re-downloads
already-installed plugins. The light profile writes its pins to
`lazy-lock-light.json` (git-ignored) to avoid touching `lazy-lock.json`.

> **Caution:** because the plugin directory is shared, running `:Lazy clean`
> while in the light profile removes the full profile's plugins (they are not
> part of the light spec). Avoid `:Lazy clean` under light; switching back to
> full will reinstall them if it happens.
