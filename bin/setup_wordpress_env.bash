#http://vccw.cc
#まずわかりやすいところにVCCWをgit cloneしましょう。
#以下2回のコマンドを実行すると、ホームディレクトリの直下にvccwというディレクトリが作られるはずです。
cd
git clone git@github.com:miya0001/vccw.git 

#次に~/.bash_profileに以下の行を追加してください。
echo 'alias vccw="wp_box=miya0001/vccw VAGRANT_VAGRANTFILE=~/vccw/Vagrantfile.theme-review vagrant"' > ~/.bash_profile
source ~/.bash_profile

# TODO
cat << EOF > /dev/null
VAGRANT_VAGRANTFILE=~/vccw/Vagrantfile
mkdir -p project_dir && $_
cp ~/vccw/provision/default.yml ./site.yml
vim site.yml
vagrant up
EOF

# wp-cli
#http://wp-cli.org/commands/

# wp-cli(http://wp-cli.org)
# A command line interface for WordPress
#brew install wp-cli
# curl https://raw.github.com/wp-cli/wp-cli.github.com/master/installer.sh | bash
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
##Then, check if it works:
#php wp-cli.phar --info

#To be able to type just wp, instead of php wp-cli.phar, you need to make the file executable and move it to somewhere in your PATH. For example:
# chmod +x wp-cli.phar
# sudo mv wp-cli.phar /usr/local/bin/wp
# echo 'PATH=${PATH}:${HOME}/.wp-cli/bin' >> ~/.bash_profile

# curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash > 
# echo 'source /FULL/PATH/TO/wp-completion.bash' >> ~/.bash_profile
# source ~/.bash_profile


