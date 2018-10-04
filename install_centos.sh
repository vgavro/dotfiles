#!/bin/bash
# NOTE: for Centos 6.10 update git from IUS, because it's too old for gitlab (and github?)
# bash <(curl -s https://raw.githubusercontent.com/vgavro/dotfiles/master/install_centos.sh)

set -e
(( EUID )) && echo 'You need to be root.' && exit 1

yum -y update
yum -y install yum-utils
yum -y groupinstall development
yum -y install vim git tig wget curl fish htop psmisc

if grep -q -i "release 6" /etc/redhat-release
then
  VER=6
else
  VER=7
fi

yum -y install https://centos$VER.iuscommunity.org/ius-release.rpm
yum -y install tmux2u python36u python36u-pip python36u-devel git2u

# NOTE: for centos6 for some reason it's not working as of fish 2.7.1 and centos 6.10
# Workaround:
# yum install -y https://download.opensuse.org/repositories/shells:/fish:/release:/2/CentOS_6/i686/fish-2.7.1-1.2.i686.rpm
yum-config-manager --add-repo http://download.opensuse.org/repositories/shells:/fish:/release:/2/CentOS_$VER/shells:fish:release:2.repo
yum -y install fish
