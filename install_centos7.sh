#!/bin/sh
(( EUID )) && echo ‘You need to be root.’ && exit 1

yum -y update
yum -y install yum-utils
yum -y groupinstall development
yum -y install vim git wget curl fish htop psmisc
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install tmux2u python36u python36u-pip python36u-devel

cd /etc/yum.repos.d/

if [ ! -f /etc/yum.repos.d/shells:fish:release:2.repo ]; then
    wget http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo \
        -O /etc/yum.repos.d/shells:fish:release:2.repo
fi
yum -y install fish
