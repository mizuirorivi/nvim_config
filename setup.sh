# install packer
# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#  ~/.config/nvim/plugin/packer.nvim

git clone https://github.com/github/copilot.vim.git \
 ~/.config/nvim/pack/github/start/copilot.vim
# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
