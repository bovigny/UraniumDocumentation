# Haproxy configuration

## Create ssl key for HAPROXY

* Generate a unique private key (KEY)
````bash
$sudo openssl genrsa -out mydomain.key 2048
````
Note:
Content in this file start with -----BEGIN RSA PRIVATE KEY-----

* Generating a Certificate Signing Request (CSR)
````bash
$ sudo openssl req -new -key mydomain.key -out mydomain.csr
````

Note:
Content in this file start with -----BEGIN CERTIFICATE REQUEST-----



* Creating a Self-Signed Certificate (CRT)
````bash
$openssl x509 -req -days 365 -in mydomain.csr -signkey mydomain.key -out mydomain.crt
````
Note:
Content in this file start with -----BEGIN CERTIFICATE-----

* Append KEY and CRT to mydomain.pem
````bash
$sudo bash -c 'cat mydomain.key mydomain.crt >> /etc/ssl/private/mydomain.pem'
````
Note:
This pem file contains 2 sections (certificates), one start with -----BEGIN RSA PRIVATE KEY----- and  another one start with -----BEGIN CERTIFICATE-----

* Specify PEM in haproxy config
````bash
$ sudo vim /etc/haproxy/haproxy.cfg
listen haproxy
  bind 0.0.0.0:443 ssl crt /etc/ssl/private/mydomain.pem
  mode  http
  option http-server-close
  option forwardfor
  reqadd X-Forwarded-Proto:\ https
  reqadd X-Forwarded-Port:\ 443
  option forwardfor if-none
  balance  roundrobin
  option  abortonclose
  server 192.168.100.224 192.168.100.224:1443 check inter 10s rise 2 fall 3 ssl verify none
````
* Restart haproxy
````bash
$ sudo service haproxy restart
````

## Configuration for Uranium Cluster
````
global
  user root
  group root

# Default Configuration

defaults
  log     global
  mode    http
  balance roundrobin
  timeout connect 5000
  timeout client  50000
  timeout server  50000

listen stats *:9999
  stats enable
  stats uri /
  stats auth admin:password

#frontend http-in
#    bind *:80
    #bind *:443 ssl crt /root/uranium.pem no-sslv3
#    bind *:4000 
    #bind swissbioisostere.daplab.ch:443 ssl crt /etc/haproxy/star.daplab.ch.haproxy.pem no-sslv3
#    redirect scheme https if !{ ssl_fc }
#    mode http
    #option httpclose
    #option forwardfor
#    reqadd X-Forwarded-Proto:\ http
#    reqadd X-Forwarded-Proto:\ https

# Configuration for Foreman
frontend http_traffic
  #  mode            http
    bind            :80,:4000
    #redirect scheme https code 301
    #option httpclose
    #option forwardfor
    #use_backend clients
#   redirect location https://uranium.unil.ch:4000
    use_backend redirection

# Configuration for Chronograf
frontend http_traffic
  #  mode            http
    bind            :80,:8888
    #redirect scheme https code 301
    #option httpclose
    #option forwardfor
    #use_backend clients
#   redirect location https://uranium.unil.ch:4000
    use_backend redirectionchrono


backend redirection
    redirect location https://uranium.unil.ch:4000

backend redirectionchrono
    redirect location https://uranium.unil.ch:8888


frontend clients
  bind uranium.unil.ch:4000 ssl crt /root/uranium.pem
  option httpclose
  option forwardfor
  use_backend clients

frontend proxies
    bind *:5000
    option tcplog
    mode tcp
    default_backend proxies

frontend chronograf
  bind uranium.unil.ch:8888 ssl crt /root/uranium.pem
  option httpclose
  option forwardfor
  use_backend chronograf
  

  #bind *:80
  #bind *:443 ssl crt /root/uranium.pem 
  #option httpclose
  #option forwardfor
  #acl url_monitoring path_beg -i /monitoring
  #use_backend chronograf if url_monitoring
  #redirect scheme https if !{ ssl_fc }
  #mode http
  #reqadd X-Forwarded-Proto:\ http
  #reqadd X-Forwarded-Proto:\ https
  #acl url_monitoring path_beg -i /monitoring
  #use_backend chronograf if url_monitoring
  #bind uranium.unil.ch:8888 ssl crt /root/uranium.pem
  #option httpclose
  #option forwardfor
  #use_backend chrono
  #use_backend redirection

backend clients

  redirect scheme https if !{ ssl_fc }
  balance roundrobin
  option httpchk GET /
  server web0-a 10.8.100.200:443 check ssl verify none


backend chronograf
  #redirect scheme https if !{ ssl_fc }
  #balance roundrobin
  #option httpchk GET /
  server web0-b 10.8.100.65:8888 check

  

backend proxies
  mode tcp
  balance roundrobin
  option ssl-hello-chk
  server web01 10.8.100.200:443 check
  ````
``
