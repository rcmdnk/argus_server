class argus_server::repositories {
  package { 'epel-release':
    ensure => installed,
    provider => rpm,
  }
  if $facts['os']['release']['major'] == '7' {
    package { 'wlcg-repo':
      ensure => installed,
      source => "http://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rp",
      provider => rpm,
    }
    package { "HEP_OSlibs":
      ensure => installed,
      require => Package['wlcg-repo'],
    }
  }
  if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '7' {
    $source = 'http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm'
  }else{
    $source = 'http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.4-1.el6.noarch.rpm'
  }
  package { 'umd-release':
    ensure => installed,
    source => "$source",
    require  => Package['epel-release'],
  }
}
