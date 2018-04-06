# Ports used for Uranium Cluster

## HAPROXY

- uranium.unil.ch:4000 -> Foreman (Provisioning)
- uranium.unil.ch:8888 -> Chronograf (Monitoring)


## Summary

| Ports | Services |
|:-----:|:--------:|
|   53  |   dns    |
|   67  |   dhcp   |
|   68  |   dhcp   |
|   69  |   dhcp   |
|   80  |   http   |
|  443  |   https  |
|  3000 |   foreman|
|  3306 |   foreman|
|  4000 |   foreman(haproxy)|
|  5432 |   foreman|
|  5910-5930 |   foreman|
|  6817 |  slurm   |
| 6818  |  slurm   |
| 6819  |  slurmdb |
| 7321  |  slurm   |
|  8140 |   foreman|
|  8443 |   foreman|
|  8888 |   chronograf (haproxy)|
|       |          |
|       |          |




## Foreman / Puppet

### Internal
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

### External (Not really necessary)

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


## Slurmd

### Internal
- firewall-cmd --permanent --zone=internal --add-port=6817/udp
- firewall-cmd --permanent --zone=internal --add-port=6817/tcp
- firewall-cmd --permanent --zone=internal --add-port=6818/udp
- firewall-cmd --permanent --zone=internal --add-port=6818/tcp
- firewall-cmd --permanent --zone=internal --add-port=6819/udp
- firewall-cmd --permanent --zone=internal --add-port=6819/tcp
- firewall-cmd --permanent --zone=internal --add-port=7321/udp
- firewall-cmd --permanent --zone=internal --add-port=7321/tcp

### External (Not really necessary)
- firewall-cmd --permanent --zone=external --add-port=6817/udp
- firewall-cmd --permanent --zone=external --add-port=6817/tcp
- firewall-cmd --permanent --zone=external --add-port=6818/udp
- firewall-cmd --permanent --zone=external --add-port=6818/tcp
- firewall-cmd --permanent --zone=external --add-port=6819/udp
- firewall-cmd --permanent --zone=external --add-port=6819/tcp
- firewall-cmd --permanent --zone=external --add-port=7321/udp
- firewall-cmd --permanent --zone=external --add-port=7321/tcp
- firewall-cmd --reload