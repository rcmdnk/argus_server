class argus_server::repositories {
  case $facts['os']['family'] {
    'RedHat': {
      package { 'epel-release':
        ensure => installed,
        provider => rpm,
      }
      case $facts['os']['release']['major'] {
        '6': {
          $umd_source = 'http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.4-1.el6.noarch.rpm'
        }
        default: {
          $umd_source = 'http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm'
        }
      }
      package { 'umd-release':
        ensure => installed,
        source => "$umd_source",
        require  => Package['epel-release'],
      }
    }
    default: {
      fail("OS family ${facts['os']['family']} is not supported by this module")
    }
  }
}
