# Samba file server configuration

> Run all from root

### Step 1. Install samba server

```apt update```

```apt install -y samba samba-client```

### Backup config

```cp /etc/samba/smb.conf /etc/samba/smb.conf_default```

### Create user and folders

```adduser smbserv```

```mkdir /home/smbserv/smb```

```chown nobody:nogroup /home/smbserv/smb```

```chmod a-w /home/smbserv/smb```

```mkdir /home/smbserv/smb/files```

```chown smbserv:smbserv /home/smbserv/smb/files```

```mkdir /home/smbserv/smb/files/samba```

```mkdir /home/smbserv/smb/files/samba/public```

```chmod -R 0755 /home/smbserv/smb/files/samba/public```

```mkdir /home/smbserv/smb/files/private```

```groupadd smbgrp```

```usermod -aG smbgrp smbserv```

```chgrp smbgrp /home/smbserv/smb/files/samba/private```

```smbpasswd -a smbserv```

### Change samba config

```nano /etc/samba/smb.conf```

### Check changes

```testparm -s```

### Restart samba daemon

```service smbd restart```

### Open all ports

```iptables -A INPUT -p tcp -m tcp --dport 445 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p tcp -m tcp --dport 139 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p udp -m udp --dport 137 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p udp -m udp --dport 138 -s 10.0.0.0/24 -j ACCEPT```

### Check opened ports

```iptables -L```
