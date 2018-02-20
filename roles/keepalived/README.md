ansible-keepalived: Ansible role for setting up keepalived 
============================================================
Christophe Bovigny - bovignyc (at) gmail.com

This role sets up keepalived for an standard setup of:
  - One virtual IP
  - Two hosts

You just need to provide an small amount of information to have it running
  - Add "keepalived" role to both hosts
  - Add variable keepalived_role: "master" | "slave" to the appropiate hosts 
  - Add variable keepalived_shared_ip: "floating IP address" to both hosts

Other variables can be configured, overwriting defaults/main.yml



Dependencies
------------
Works with centos/redhat and Debian/Ubuntu

Role Variables
--------------
	keepalived_auth_pass: "1111"
	keepalived_role: "MASTER"
	keepalived_router_id: "52"
	keepalived_shared_iface: "eth0"
	keepalived_shared_ip: "192.168.1.1"
	keepalived_check_process: "keepalived"
	keepalived_priority: "100"
	keepalived_backup_priority: "50"

Example Playbook
-------------------------

    - hosts: s1
      roles:
         - { role: keepalived, keepalived_shared_ip: "192.168.1.1", keepalived_role: "master" }

    - hosts: s2
      roles:
         - { role: keepalived, keepalived_shared_ip: "192.168.1.1", keepalived_role: "slave" }


    - name: apply common configuration to gw nodes
      hosts: gw
      user: uraniumadm
      sudo: true
      roles:
        - keepalived


License
-------
Apache

