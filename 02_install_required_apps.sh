/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source ~/.zshrc

touch ~/.config/nvim
touch ~/.config/btop
touch ~/.config/alacritty/

brew install nvim
brew install alacritty
brew install --cask font-meslo-lg-nerd-font
brew install btop
