## INSTALL

Before use - please ensure this PRs are merged:

* https://github.com/archlinux/archinstall/pull/896
* https://github.com/archlinux/archinstall/pull/895
* https://github.com/archlinux/archinstall/pull/854

### Connect to internet

[ArchWiki](https://wiki.archlinux.org/title/installation_guide#Connect_to_the_internet)

```
rfkill  # ensure wireless card is not blocked
iwctl device list  # ensure wlan0 is on the list
iwctl station wlan0 scan; iwctl station wlan0 get-networks  # view all networks
iwctl --passphrase=PASSPHRASE station wlan0 connect NETWORK_NAME
```

### Run installer

Check `config.json` for `hostname` and `harddrives`, `harddrive` name in `disk_layouts.json` should match.

```
lsblk  # ensure harddrive name match, hostname may be changed in interactive mode
chmod +x ./archinstall.sh
./archinstall.sh
```
