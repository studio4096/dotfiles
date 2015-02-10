# modern.ie 
## https://www.modern.ie/ja-jp/virtualization-tools#downloads
# IE8 XP
#curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE8_XP/IE8.XP.For.MacVirtualBox.ova"
# IE9 Win7
#curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE9_Win7/IE9.Win7.For.MacVirtualBox.part{1.sfx,2.rar,3.rar,4.rar,5.rar}"
# IE10 Win8
#curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE10_Win8/IE10.Win8.For.MacVirtualBox.part{1.sfx,2.rar,3.rar}"

# refs. http://qiita.com/yteraoka/items/06fc91f37913c938d936
for line in $(cat << 'EOF' 
xpie6,http://aka.ms/vagrant-xp-ie6
xpie8,http://aka.ms/vagrant-xp-ie8
vistaie7,http://aka.ms/vagrant-vista-ie7
win7ie8,http://aka.ms/vagrant-win7-ie8
win7ie9,http://aka.ms/vagrant-win7-ie9
win7ie10,http://aka.ms/vagrant-win7-ie10
win7ie11,http://aka.ms/vagrant-win7-ie11
win8ie10,http://aka.ms/vagrant-win8-ie10
win81ie11,http://aka.ms/vagrant-win81-ie11
EOF
);do
    boxname=$(echo ${line} | cut -d ',' -f 1)
    boxurl=$(echo ${line} | cut -d ',' -f 2)
    vagrant box add $boxname $boxurl
done
# vagrant init win81ie11

#日本語環境
# refs. http://qiita.com/hnakamur/items/5f2f9e817dd0de60abb2
# refs. http://qiita.com/hnakamur/items/cd37c9c8826afe4b4dda

