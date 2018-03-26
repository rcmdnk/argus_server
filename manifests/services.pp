class argus_server::services {

  service { 'argus-pap':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  service { 'argus-pdp':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  service { 'argus-pepd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
