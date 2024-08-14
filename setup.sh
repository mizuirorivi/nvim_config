#!/bin/bash
# setup
## use packer
nvim --headless -c ':PackerInstall' -c ':qa'
# install language server
## rust
mkdir ~/.local/bin
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
nvim --headless -c ':CocInstall coc-rust-analyzer' -c ':qa'
## lua 
git clone --depth 1 https://github.com/sumneko/lua-language-server ~/.local/bin/lua-language-server
pushd ~/.local/bin/lua-language-server
git submodule update --init --recursive
pushd 3rd/luamake
./compile/install.sh
popd
./3rd/luamake/luamake rebuild
popd

git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
