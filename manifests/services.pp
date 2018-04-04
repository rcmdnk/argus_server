class argus_server::services {

  exec { 'run fetch-crl':
    # fetch-crl returns false if there's a problem with any of the CAs and therefore blocking
    # any further argus configuration, ignore return value to avoid this (always return true)
    command     => '/usr/sbin/fetch-crl || true',
    require     => Class['fetchcrl::install'],
    unless      => '/bin/ls /etc/grid-security/certificates/*.r0 1>/dev/null 2>&1'
  }

  exec { 'hostcert update':
    command   => '/usr/bin/systemctl restart argus-pap argus-pdp argus-pepd',
    refreshonly => true,
    subscribe => [
      File['/etc/grid-security/hostcert.pem'],
      File['/etc/grid-security/hostkey.pem'],
    ],
  }

  service { 'argus-pap':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require     => Exec['run fetch-crl'],
    notify => Service['argus-pdp'],
  }
  
  service { 'argus-pdp':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    notify => Service['argus-pepd'],
  }

  service { 'argus-pepd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
