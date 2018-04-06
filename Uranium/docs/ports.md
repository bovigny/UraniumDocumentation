# Ports used for Uranium Cluster

## HAPROXY

- uranium.unil.ch:4000 -> Foreman (Provisioning)
- uranium.unil.ch:8888 -> Chronograf (Monitoring)


## Slurm

- 6817 (UPD/TCP)
- 6818 (UDP/TCP)
- 6819 (TCP)
- 7321 (UDP/TCP)


## Foreman / Puppet

- firewall-cmd --permanent --add-port=53/tcp
- firewall-cmd --permanent --add-port=67-69/udp
- firewall-cmd --permanent --add-port=80/tcp
- firewall-cmd --permanent --add-port=443/tcp
- firewall-cmd --permanent --add-port=3000/tcp
- firewall-cmd --permanent --add-port=3306/tcp
- firewall-cmd --permanent --add-port=5910-5930/tcp
- firewall-cmd --permanent --add-port=5432/tcp
- firewall-cmd --permanent --add-port=8140/tcp
- firewall-cmd --permanent --add-port=8443/tcp


## Firewalld

- firewall-cmd --permanent --zone=internal --add-port=6817/udp
- firewall-cmd --permanent --zone=internal --add-port=6817/tcp
- firewall-cmd --permanent --zone=internal --add-port=6818/tcp
- firewall-cmd --permanent --zone=internal --add-port=6818/tcp
- firewall-cmd --permanent --zone=internal --add-port=7321/tcp
- firewall-cmd --permanent --zone=internal --add-port=7321/tcp
- firewall-cmd --reload