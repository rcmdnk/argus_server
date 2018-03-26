class argus_server::install {

    package { $argus_server::packages:
      ensure => 'present',
    }
 
}
