#! /usr/bin/env bash

#---| Arch Linux Quick Install |---#

# This script is designed to be a quick
# installer for arch linux.
# If you want customization, look away.

if [[ $USER != 'root' ]]; then
    echo "You should be root for this..."
    exit
fi

echo
echo "Partitioning"
echo
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart 1 0% 512M
parted -s /dev/sda mkpart 2 512M 100%
parted -s /dev/sda set 1 boot on

echo
echo "Making Filesystems"
echo
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

echo
echo "Mounting Filesystems"
echo
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

echo
echo "Pacstrapping Base"
echo
pacstrap /mnt base base-devel git vim

echo
echo "Generating FSTAB"
echo
genfstab -U /mnt >> /mnt/etc/fstab

echo
echo "Housekeeping"
echo
echo "en_CA.UTF-8 UTF-8" >> /mnt/etc/locale.gen
arch-chroot /mnt "locale-gen"
bootctl install --path=/mnt/boot
cat << EOF | tee /mnt/boot/loader/loader.conf
default arch
timeout 1
EOF
cat << EOF | tee /mnt/boot/loader/entries/arch.conf
title ARCH
linux /vmlinuz-linux
initrd /initramfs-linux.img
options rw root=$(blkid -o export /dev/sda2 | grep PARTUUID)
EOF
read -p "Enter Hostname: " hostname
echo "$hostname" > /mnt/etc/hostname
arch-chroot /mnt passwd

echo 
echo "Done"
echo
reboot
