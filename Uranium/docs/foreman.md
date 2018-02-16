# Pre Installation

First check carefully that the hostname is correctly set :

```bash

[root@localhost ~]# hostname -f
localhost

[root@foreman ~]# cat /etc/hosts
192.168.56.101 foreman.uranium.lan foreman
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

[root@localhost ~]# hostnamectl status
   Static hostname: localhost.localdomain
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 9ffd412be62d47208ebcd60ab924f696
           Boot ID: 78b979e2c1e54a269cc62e05602fd3e9
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-693.17.1.el7.x86_64
      Architecture: x86-64

[root@localhost ~]# hostnamectl set-hostname foreman.uranium.lan

```

The Foreman installer uses Puppet to install Foreman. This guide assumes that you have a newly installed operating system, on which the installer will setup Foreman, a Puppet master with Passenger and the Smart Proxy by default.

## Repositories

Using a recent version of Puppet is recommended, which is available from the Puppet Labs repository. You may skip this and use the older version from EPEL without a problem, however it has reduced community support.

```bash

yum -y install https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/1.16/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer
```

# Installation 
```bash

foreman-installer

```
After it completes, the installer will print some details about where to find Foreman and the Smart Proxy and Puppet master if they were installed along Foreman. Output should be similar to this:

```bash

 Success!
  * Foreman is running at https://foreman.uranium.lan
      Initial credentials are admin / cscaSXeSpc9v3mcp
  * Foreman Proxy is running at https://foreman.uranium.lan:8443
  * Puppetmaster is running at port 8140
  The full log is at /var/log/foreman-installer/foreman.log
```
## Enable Smart-Proxy and install the foreman-smart-proxy with DHCP/TFTP/DNS

You have to setup a provisionning subnet and after foreman propose you to install the smart-proxy with or without dhcp/dns/tftp

```bash
foreman-installer   --enable-foreman-proxy   --foreman-proxy-tftp=true   --foreman-proxy-tftp-servername=192.168.100.10   --foreman-proxy-dhcp=true   --foreman-proxy-dhcp-interface=enp0s8   --foreman-proxy-dhcp-gateway=192.168.100.10   --foreman-proxy-dhcp-nameservers="192.168.100.10"   --foreman-proxy-dns=true   --foreman-proxy-dns-interface=enp0s8   --foreman-proxy-dns-zone=uranium.lan   --foreman-proxy-dns-reverse=100.168.192.in-addr.arpa   --foreman-proxy-dns-forwarders=130.223.8.20   --foreman-proxy-dns-forwarders=130.223.4.5   --foreman-proxy-foreman-base-url=https://foreman.uranium.lan   --foreman-proxy-oauth-consumer-key=CZyZrs8PhALe9bwdXHSeS86SiQmGEnWW   --foreman-proxy-oauth-consumer-secret=G5LNi5SPdmyymMYEdTkysF8xvJnJAXCW

```

## DHCP
/etc/dhcpd/dhcpd.conf

```
# dhcpd.conf
omapi-port 7911;

default-lease-time 43200;
max-lease-time 86400;



ddns-update-style none;

option domain-name "uranium.lan";
option domain-name-servers 192.168.100.10;
option ntp-servers none;

allow booting;
allow bootp;

option fqdn.no-client-update    on;  # set the "O" and "S" flag bits
option fqdn.rcode2            255;
option pxegrub code 150 = text ;

# Bootfile Handoff
next-server 192.168.100.10;
option architecture code 93 = unsigned integer 16 ;
if option architecture = 00:06 {
  filename "grub2/shim.efi";
} elsif option architecture = 00:07 {
  filename "grub2/shim.efi";
} elsif option architecture = 00:09 {
  filename "grub2/shim.efi";
} else {
  filename "pxelinux.0";
}

log-facility local7;

include "/etc/dhcp/dhcpd.hosts";
# uranium.lan
subnet 192.168.100.0 netmask 255.255.255.0 {

  option subnet-mask 255.255.255.0;
  # give the ip address of your gateway
  option routers 192.168.100.10;
}
```
/etc/dhcpd/dhcpd.hosts
```
# static DHCP hosts
host TestForeman {
    hardware ethernet 08:00:27:86:5a:47;
    fixed-address 192.168.100.11;
}
```
## DNS
db.100.168.192.in-addr.arpa 

```
$TTL 10800
@ IN SOA foreman.uranium.lan. root.100.168.192.in-addr.arpa. (
	1	;Serial
	86400	;Refresh
	3600	;Retry
	604800	;Expire
	3600	;Negative caching TTL
)

@ IN NS foreman.uranium.lan.

; Test machines
testforeman    IN      A       192.168.100.11
testforeman2   IN      A       192.168.100.12
; PTR Test Machine
11      IN      PTR     testforeman.uranium.lan.
12      IN      PTR     testforeman2.uranium.lan.
```


db.uranium.lan
```
$TTL 10800
@ IN SOA foreman.uranium.lan. root.uranium.lan. (
	1	;Serial
	86400	;Refresh
	3600	;Retry
	604800	;Expire
	3600	;Negative caching TTL
)

@ IN NS foreman.uranium.lan.

foreman.uranium.lan. IN A 192.168.100.10

; Test machines
;
@                               IN      A       192.168.100.11
@                               IN      A       192.168.100.12

testforeman                     IN      A       192.168.100.11
testforeman2                    IN      A       192.168.100.12

```

https://www.itzgeek.com/how-tos/linux/centos-how-tos/configure-slave-dns-bind-on-centos-7-rhel-7.html


## TFTP

Do not forget to chown foreman-proxy:foreman-proxy /var/lib/tftpboot/pxelinux.cfg, that enables the write access to foreman-proxy user.

