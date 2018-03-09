class privileges (

   $publickey,
   $privatekey
){
   group{ "uranium":
	ensure => present,
	gid => 1200,
   } ->
   user { "uraniumadm":
      ensure  => 'present',
      managehome => true,
      comment => 'Admin Uranium User,',
      home       => '/home/uraniumadm',
      password => '$5$I0r8K0UL$VczpMrsuMLHSCHf/8DTSA5DOUjW9xs06uATFCHN8p74',
      gid     => '1200',
      groups  => ['uranium'],
      shell   => '/bin/bash',
      uid     => '1200',
    } ->
   sudo::conf { "admins":
   ensure  => present,
   content => 'uraniumadm ALL=(ALL) ALL',
   } ->
   file { "/home/uraniumadm/.ssh":
    ensure => directory,
    mode => '0700',
    owner => 'uraniumadm',
    group => 'uranium',
    } ->
    file { "/home/uraniumadm/.ssh/id_rsa":
    ensure  => file,
    mode    => '0400',
    owner => 'uraniumadm',
    group => 'uranium',
    content => $privatekey,

    } ->
    file { "/home/uraniumadm/.ssh/id_rsa.pub":
    ensure  => file,
    mode    => '0644',
    owner => 'uraniumadm',
    group => 'uranium',
    content => inline_template("${publickey} ${::fqdn}"),
    } ->
    file { "/home/uraniumadm/.ssh/authorized_keys":
    ensure => file,
    mode => '0600',
    owner => 'uraniumadm',
    group => 'uranium',
    content => inline_template("${publickey}"),
    }

 }
