#!/bin/sh

#This script is licensed under the GNU GPLv3
#Please note this script is made specifically to install Gentoo on a Thinkpad X250
#Also note that it is designed to get a setup of my liking, so you may modify it to your liking if you have different preferences

#Please run this only after you ran install.sh

#chrooting
source /etc/profile
export PS1="(chroot) ${PS1}"

#configuring portage
emerge-webrsync
emerge --sync

#WM config - uncomment following line
#eselect profile set 1

#KDE condig
eselect profile set 8

#USE flags for KDE
echo "USE=\"-gtk -gnome qt4 qt5 kde dvd alsa cdr\"" >> /etc/portage/make.conf

#Temporarily accept all licenses to avoid problems
echo "ACCEPT_LICENSE=\"*\"" >> /etc/portage/make.conf

#setting exception for kernel
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" >> /etc/portage/package.license/kernel
echo "sys-firmware/intel-microcode intel-ucode" >> /etc/portage/package.license/kernel

#configuring locales
echo "LANG=\"en_US.UTF-8\"" >> /etc/env.d/02locale
echo "LC_COLLATE=\"C\"" >> /etc/env.d/02locale

#reload environment
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

# manual kernel install
emerge sys-kernel/gentoo-sources
emerge sys-apps/pciutils
cd /usr/src/linux
#manual kernel config
make menuconfig
#kernel compiling
make && make modules_install
make install

#making intramfs for precaution
emerge sys-kernel/genkernel
genkernel --install --kernel-config=/path/to/used/kernel.config initramfs
genkernel --lvm --mdadm --install --kernel-config=/path/to/used/kernel.config initramfs
ls /boot/initramfs*

#automatic install - uncomment these lines
#emerge --ask sys-kernel/genkernel
#genkernel all
#ls /boot/vmlinu* /boot/initramfs*

#kernel modules - CHANGE KERNEL VERSION IN THE FUTURE
find /lib/modules/5.11.10/ -type f -iname '*.o' -or -iname '*.ko' | less
mkdir -p /etc/modules-load.d 
echo "3c59x" >> /etc/modules-load.d/network.conf

#fstab
echo "/dev/sda1   none         swap    sw                   0 0" >> /etc/fstab
echo "/dev/sda2   /            ext4    noatime              0 1" >> /etc/fstab
echo "/dev/sda3   /home        ext4    defaults             0 2" >> /etc/fstab

#setting hostname and domainname
echo "hostname=\"madness\"" >> /etc/conf.d/hostname
echo "dns_domain_lo=\"homenetwork\"" >> /etc/conf.d/net

#configuring network
emerge --noreplace net-misc/netifrc
echo "config_eth0=\"dhcp\"" >> /etc/conf.d/net

#autostart networking at boot
cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default

#host file
echo "127.0.0.1     madness.homenetwork madness localhost" >> /etc/hosts

#set root password
passwd

#configure boot services, keymap and clock
nano -w /etc/rc.conf
nano -w /etc/conf.d/keymaps
nano -w /etc/conf.d/hwclock

#system logger
emerge app-admin/sysklogd
rc-update add sysklogd default

#cron daemon
emerge sys-process/cronie
rc-update add cronie default

#DHCP and wifi
emerge net-misc/dhcpcd
emerge net-wireless/iw net-wireless/wpa_supplicant

#GRUB
emerge --ask --verbose sys-boot/grub:2
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#unmounting and rebooting
exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
