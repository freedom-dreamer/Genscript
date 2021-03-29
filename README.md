# Genscript
Install Gentoo on a Thinkpad X250 with my scripts!

Please note that the script is designed for Thinkpad X250s with LEGACY BIOS, if you desire to install it on another
PC or on UEFI, you may edit this script, but I advise you to directly use another one.

What you need:
- 2 USBs (since LEGACY BIOS won't usually detect two partitions on a USB)
- A Lenovo Thinkpad X250
- A working internet connection (preferrably wired)

Instructions:
1.  Make a bootable Gentoo USB
2.  Put install.sh, install1.sh, post-install.sh and the standard OpenRC Stage3 tarball in a second USB
3.  Set your BIOS to LEGACY if you haven't already
4.  Boot from the Gentoo USB
5.  Mount the script+tarball USB to a mount point of your choosing
    (I advise you follow these steps:
      0. mkdir /mnt/script
      1. lsblk
      2. mount /dev/sdX1 /mnt/script"
     but you may mount it on another point, just I do not recommend mounting it directly on /mnt at this point)
6.  cd into the mounted USB (cd /mnt/script if you followed my instructions)
7.  run install.sh (./install.sh)
8.  Now it will exit the script while chrooted
9.  Remount the script+tarball USB (this time you may mount it directly to /mnt)
10. unmount all the volumes and reboot
11. remove the Gentoo USB
12. Boot into the installed Gentoo system
13. remount the tarball+script USB to what mount point you want
14. cd into the mountpoint you chose (let's say cd /mnt)
15. run post-install.sh (./post-install.sh)
16. DONE! You may reboot or change user if you wish!

KNOWN ISSUES:
Sometimes during the post install emerge will say that config files need to be updated, to fix this follow these steps:
1.  dispatch-conf
2.  type u for "use new" when prompted (might be necessary to do it multiple times)
3.  re-run post-install.sh (./post-install.sh)

ENJOY GENTOO!!
