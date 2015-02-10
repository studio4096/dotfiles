mkdir -p ~/.ssh && chmod 700 $_
ls -ld ~/.ssh
# drwx------  2 username  staff  68  2  9 11:56 .ssh/
touch ~/.ssh/config && chmod 600 $_
if [ -f ~/.ssh/id_rsa ]; then
    cat << 'EOF'
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa):  <- Press ［Enter］key.
Enter passphrase (empty for no passphrase):  <- Input a passphrase.
Enter same passphrase again:  <- Input the passphrase again.
Your identification has been saved in /home/username/.ssh/id_rsa.
Your public key has been saved in /home/username/.ssh/id_rsa.pub.
The key fingerprint is:
f9:81:b6:c7:8f:b9:aa:3e:0e:c6:bd:35:19:a1:1e:06 username@hostname

EOF
    (
        cd ~/.ssh
        ssh-keygen -t rsa
    )
    chmod 600 .ssh/id_rsa*
    chmod 644 .ssh/id_rsa.pub
fi
ls -l ~/.ssh/
# total 16
# -rw-------  1 username  staff     0  2  9 11:56 config
# -rw-------  1 username  staff  1743  2  9 12:00 id_rsa
# -rw-r--r--  1 username  staff   407  2  9 12:00 id_rsa.pub

