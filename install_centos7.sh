#!/bin/sh
set -e
(( EUID )) && echo 'You need to be root.' && exit 1

yum -y update
yum -y install yum-utils
yum -y groupinstall development
yum -y install vim git tig wget curl fish htop psmisc iproute

yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install tmux2u python36u python36u-pip python36u-devel

yum-config-manager --add-repo http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
yum -y install fish
