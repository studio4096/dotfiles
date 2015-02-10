#!/usr/bin/env bash
# refs. http://www.d-wood.com/blog/2014/03/14_5816.html
brew install zsh --disable-etcdir
brew install zsh-completions
# TODO .zshrc

echo "Add $(which zsh) to /etc/shells." 
sudo sh -c 'echo $(which zsh) >> /etc/shells'

echo "Change user default shell."
chsh -s /usr/local/bin/zsh

