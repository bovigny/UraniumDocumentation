# Firewalld on GW1 and GW2

# Add interfaces em1 and em2
- firewall-cmd --zone=external --add interface=em1 --permanent
- firewall-cmd --zone=internal --add-interface=em2 --permanent
- firewall-cmd --list-all-zones


## In case of change
- firewall-cmd --zone=internal --remove-interface=em1
- firewall-cmd --zone=external --change-interface=em1
- firewall-cmd --get-active-zone
- firewall-cmd --zone=internal --change-interface=em2
- firewall-cmd --get-active-zone
- firewall-cmd --complete-reload

# Add masquerade

- firewall-cmd --zone-external --add-masquerade --permanent

# Add NAT em1(External) to em2(Internal)

- firewall-cmd  --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o em1 -j MASQUERADE -s 10.8.100.0/24


# Add services Zone internal (Private network)

- firewall-cmd --permanent --zone=internal --add-service=dhcp
- firewall-cmd --permanent --zone=internal --add-service=tftp
- firewall-cmd --permanent --zone=internal --add-service=dns
- firewall-cmd --permanent --zone=internal --add-service=http
- firewall-cmd --permanent --zone=internal --add-service=nfs
- firewall-cmd --permanent --zone=internal --add-service=ssh
- firewall-cmd --permanent --zone=internal --add-service=smtp

# Add services Zone external (Public network(unil))

- firewall-cmd --permanent --zone=external --add-service=dhcp
- firewall-cmd --permanent --zone=external --add-service=tftp
- firewall-cmd --permanent --zone=external --add-service=dns
- firewall-cmd --permanent --zone=external --add-service=http
- firewall-cmd --permanent --zone=external --add-service=nfs
- firewall-cmd --permanent --zone=external --add-service=ssh
- firewall-cmd --permanent --zone=external --add-service=smtp

# Keepalived GW1 and GW2

see links [https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/load_balancer_administration/s1-lvs-multi-vsa]

- firewall-cmd --add-rich-rule='rule protocol value="vrrp" accept' --permanent


# Add ports Zone internal (Private network)

- firewall-cmd --permanent --zone=internal --add-port=53/tcp
- firewall-cmd --permanent --zone=internal --add-port=67-69/udp
- firewall-cmd --permanent --zone=internal --add-port=80/tcp
- firewall-cmd --permanent --zone=internal --add-port=443/tcp
- firewall-cmd --permanent --zone=internal --add-port=3000/tcp
- firewall-cmd --permanent --zone=internal --add-port=3306/tcp
- firewall-cmd --permanent --zone=internal --add-port=5910-5930/tcp
- firewall-cmd --permanent --zone=internal --add-port=5432/tcp
- firewall-cmd --permanent --zone=internal --add-port=8140/tcp
- firewall-cmd --permanent --zone=internal --add-port=8443/tcp
- firewall-cmd --permanent --zone=internal --add-port=22/tcp
- firewall-cmd --permanent --zone=internal --add-port=5901/udp
- firewall-cmd --permanent --zone=internal --add-port=5901/tcp
- firewall-cmd --permanent --zone=internal --add-port=6817/udp
- firewall-cmd --permanent --zone=internal --add-port=6817/tcp
- firewall-cmd --permanent --zone=internal --add-port=6818/udp
- firewall-cmd --permanent --zone=internal --add-port=6818/tcp
- firewall-cmd --permanent --zone=internal --add-port=7321/tcp
- firewall-cmd --permanent --zone=internal --add-port=4000/tcp
- firewall-cmd --permanent --zone=internal --add-port=5000/tcp
- firewall-cmd --permanent --zone=internal --add-port=8888/tcp
- firewall-cmd --permanent --zone=internal --add-port=9092/tcp
- firewall-cmd --permanent --zone=internal --add-port=25/tcp
- firewall-cmd --complete-reload

# Add ports Zone external (Public network(unil))

- firewall-cmd --permanent --zone=external --add-port=53/tcp
- firewall-cmd --permanent --zone=external --add-port=67-69/udp
- firewall-cmd --permanent --zone=external --add-port=80/tcp
- firewall-cmd --permanent --zone=external --add-port=443/tcp
- firewall-cmd --permanent --zone=external --add-port=3000/tcp
- firewall-cmd --permanent --zone=external --add-port=3306/tcp
- firewall-cmd --permanent --zone=external --add-port=5910-5930/tcp
- firewall-cmd --permanent --zone=external --add-port=5432/tcp
- firewall-cmd --permanent --zone=external --add-port=8140/tcp
- firewall-cmd --permanent --zone=external --add-port=8443/tcp
- firewall-cmd --permanent --zone=external --add-port=22/tcp
- firewall-cmd --permanent --zone=external --add-port=5901/udp
- firewall-cmd --permanent --zone=external --add-port=5901/tcp
- firewall-cmd --permanent --zone=external --add-port=6817/udp
- firewall-cmd --permanent --zone=external --add-port=6817/tcp
- firewall-cmd --permanent --zone=external --add-port=6818/udp
- firewall-cmd --permanent --zone=external --add-port=6818/tcp
- firewall-cmd --permanent --zone=external --add-port=7321/tcp
- firewall-cmd --permanent --zone=external --add-port=4000/tcp
- firewall-cmd --permanent --zone=external --add-port=5000/tcp
- firewall-cmd --permanent --zone=external --add-port=8888/tcp
- firewall-cmd --permanent --zone=external --add-port=9092/tcp
- firewall-cmd --permanent --zone=external --add-port=25/tcp
- firewall-cmd --complete-reload