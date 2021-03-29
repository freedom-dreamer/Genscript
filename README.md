# Genscript
Install Gentoo on a Thinkpad X250 with my scripts!

Please note that the script is designed for Thinkpad X250s with LEGACY BIOS, if you desire to install it on another
PC or on UEFI, you may edit this script, but I advise you to directly use another one.

What you need:
- 2 USBs (since LEGACY BIOS won't usually detect two partitions on a USB)
- A Lenovo Thinkpad X250
- A working internet connection (preferrably wired)

Instructions:
0.  Make a bootable Gentoo USB
1.  Put install.sh, install1.sh, post-install.sh and the standard OpenRC Stage3 tarball in a second USB
2.  Set your BIOS to LEGACY if you haven't already
3.  Boot from the Gentoo USB
4.  Mount the script+tarball USB to a mount point of your choosing
    (I advise you follow these steps:
      0. mkdir /mnt/script
      1. lsblk
      2. mount /dev/sdX1 /mnt/script"
     but you may mount it on another point, just I do not recommend mounting it directly on /mnt at this point)
5.  cd into the mounted USB (cd /mnt/script if you followed my instructions)
6.  run install.sh (./install.sh)
7.  Now it will exit the script while chrooted
8.  Remount the script+tarball USB (this time you may mount it directly to /mnt)
9.  unmount all the volumes and reboot
10. remove the Gentoo USB
11. Boot into the installed Gentoo system
12. remount the tarball+script USB to what mount point you want
13. cd into the mountpoint you chose (let's say cd /mnt)
14. run post-install.sh (./post-install.sh)
15. DONE! You may reboot or change user if you wish!

KNOWN ISSUES:
Sometimes during the post install emerge will say that config files need to be updated, to fix this follow these steps:
0.  dispatch-conf
2.  type u for "use new" when prompted (might be necessary to do it multiple times)
3.  re-run post-install.sh (./post-install.sh)

ENJOY GENTOO!!
