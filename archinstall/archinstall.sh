#!/bin/bash
set -xe

## Update archinstall
[[ ! -d archinstall ]] && {
  pacman --noconfirm -Sy git python-pip
  pip uninstall -y archinstall
  git clone http://github.com/archlinux/archinstall
  cd archinstall
  python setup.py install
  cd -
}

python3 -m archinstall --config config.json --creds creds.json --disk_layouts disk_layouts.json
