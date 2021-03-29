#This script is licensed under the GNU GPLv3
#Please run this only after you will have rebooted from the finished Gentoo install

#adding a user, change it to your name, unless your name is defaultuser
useradd -m -G users,wheel,audio -s /bin/bash defaultuser
passwd defaultuser

#remove stage3 tarball file
rm /stage3-*.tar.*

#This installation script uses the X.org window system, if you want another one, you must change the script
emerge --autounmask-write --autounmask-backtrack=y x11-base/xorg-x11
echo "Section \"Monitor\"" >> /etc/X11/xorg.conf.d/90-monitor.conf
echo "    Identifier             \"<default monitor>\"" >> /etc/X11/xorg.conf.d/90-monitor.conf
echo "    DisplaySize             276 156    \# Physical display dimensions in millimeters" >> /etc/X11/xorg.conf.d/90-monitor.conf
echo "EndSection" >> /etc/X11/xorg.conf.d/90-monitor.conf
touch ~/.xinitrc
#replace defaultuser with your username!!
touch /home/defaultuser/.xinitrc

#KDE install for root and default user, remember to replace defaultuser with your name
emerge --autounmask-write --autounmask-backtrack=y kde-plasma/plasma-meta
echo "#!/bin/sh" >> ~/.xinitrc
echo "exec dbus-launch --exit-with-session startplasma-x11" >> ~/.xinitrc
echo "#!/bin/sh" >> /home/defaultuser/.xinitrc
echo "exec dbus-launch --exit-with-session startplasma-x11" >> /home/defaultuser/.xinitrc

#qtile install remember to replace defaultuser with your name
#emerge --ask x11-wm/qtile
#echo "exec qtile" >> ~/.xinitrc
#echo "exec qtile" >> /home/defaultuser/.xinitrc

#Accepting only FSF approved licenses for further programs, as it should be
echo "ACCEPT_LICENSE=\"-* @FSF-APPROVED\"" >> /etc/portage/make.conf
