## --- for node.js ------------------------------

#nodebrew install-binary stable
#nodebrew use stable
nodebrew install-binary v0.10.x
nodebrew use v0.10.x


# global npm
# candidate:
#    less
#    sass
#    jade
#    coffee-script
#    webpack
for f in $(cat << 'EOF'
yo
bower
grunt-cli
gulp
harp
browser-sync
generator-mobile-boilerplate
generator-h5bp
EOF
); do
    npm install -g $f
done
npm cache clean

# use stable node.js
#nave use stable

# npm WARN Building the local index for the first time, please be patient

#https://github.com/h5bp/generator-mobile-boilerplate
#yo mobile-boilerplate
#generator-h5bp
#https://github.com/h5bp/generator-h5bp
# yo h5bp
