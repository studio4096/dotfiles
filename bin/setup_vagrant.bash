#!/usr/bin/env bash

# setup_vagrant
# About Vagrant.
#http://www.slideshare.net/shin1x1/vagrant-php?related=1

# Vagrant plugins
echo -e "\n####### Vagrant plugin Update #######\n"
vagrant plugin install vagrant-aws
vagrant plugin install vagrant-hostsupdater
vagrant plugin update


