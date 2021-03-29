#!/bin/sh

#This script is licensed under the GNU GPLv3
#Please note this script is made specifically to install Gentoo on a Thinkpad X250
#Also note that it is designed to get a setup of my liking, so you may modify it to your liking if you have different preferences


#First let's completely erase data from /dev/sda
dd if=/dev/zero of=/dev/sda status=progress

#Let's set up the net, as it may be needed during the installation, even though this script requires you to have the Hardened stage3 tarball
net-setup eth0
dhcpd eth0

#Now let's write the MSDOS label on /dev/sda and create a /, a /home and a swap  partition
echo "please create 3 separate partitions, on /dev/sda"
echo "/dev/sda1 should be the swap /dev/sda2 should be the root and /dev/sda3 the home!"
sleep 5
cfdisk /dev/sda

#activating swap
mkswap /dev/sda1
swapon /dev/sda1

#making directories and mounting partitions
mkdir /mnt/gentoo
mkdir /mnt/gentoo/home
mount /dev/sda2 /mnt/gentoo
mount /dev/sda3 /mnt/gentoo/home

#copying and extracting tarball
cp ./stage3-*.tar.xz /mnt/gentoo
cd /mnt/gentoo
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

#configuring cflags
echo "CFLAGS=\"-O2 -pipe -march=native\"" >> /etc/portage/make.conf
echo "CPU_FLAGS_X86=\"aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3\"" >> /etc/portage/make.conf
echo "MAKEOPTS=\"-j5 -l5\"" >> /etc/portage/make.conf
echo "INPUT_DEVICES=\"evdev synaptics\"" >> /etc/portage/make.conf
echo "VIDEO_CARDS=\"intel i965\"" >> /etc/portage/make.conf

#copying dns info
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

#mount filesystems
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

#chrooting
chroot /mnt/gentoo /bin/bash
exit
