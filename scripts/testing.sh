#!/bin/sh

# Restore to a clean slate.
zpool import -f -d /dev/disk/by-id -R /mnt zroot -N
zfs mount zroot/root
zfs mount -a
mount /dev/nvme0n1p1 /mnt/boot

zfs rollback -r zroot@preinstall
zfs rollback -r zroot/home@preinstall
zfs rollback -r zroot/home/root@preinstall
zfs rollback -r zroot/nix@preinstall
zfs rollback -r zroot/root@preinstall
zfs rollback -r zroot/var@preinstall
zfs rollback -r zroot/var/log@preinstall

rm -rf /mnt/boot/*
rm -rf /mnt/home/root/

ls -laR /mnt
