#!/bin/bash
apt update && apt install -y samba samba-client
mv /etc/samba/smb.conf /etc/samba/smb.conf_backup
mkdir /media/samba
mkdir /media/samba/public
mkdir /media/samba/private
groupadd smbgrp
useradd user1
usermod -aG smbgrp user1
chgrp smbgrp /media/samba/private
smbpasswd -a user1
cp smb.conf /etc/samba/
testparm -s
service smbd restart
service smbd status
chmod -R 0777 /media/samba/public
iptables -A INPUT -p tcp -m tcp --dport 445 -s 10.0.0.0/24 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 139 -s 10.0.0.0/24 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -s 10.0.0.0/24 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -s 10.0.0.0/24 -j ACCEPT
iptables -L
