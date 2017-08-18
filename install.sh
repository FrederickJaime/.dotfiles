set -e

# Check if homebrew is installed and if not install it
which -s brew
if [[ $? !=0 ]] ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else 
  brew update
fi

#Brew specific installs
# -- Check if Git is installed
echo "Checking if git is installed"
which -s git || brew install git
# -- Check if node is installed
echo "Checking for node"
node --version
if [[ $? != 0 ]] ; then
  brew install node
fi
# -- Install zsh
echo "Checking zsh"
which -s zsh || brew install zsh

# Change shell to zsh
echo "Changing shell to zsh"
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)

# Install zsh theme
npm install -g spaceship-zsh-theme

echo -n "SymLinking dotfiles..."
#Symlink .zshrc and .vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
mkdir $HOME/.vim/
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
echo 'done!'