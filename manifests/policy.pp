class argus_server::policy {

  $restart_cmd='service argus-pap restart; service argus-pdp restart; service argus-pepd restart'

  notify { "$restart_cmd":}
  # XML policy to load
  file { '/etc/argus/argus_policy.xml':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/argus_policy.erb"),
  }

  # Restart argus if needed
  exec {'ssl restart':
    path => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => $restat_cmd,
    onlyif  => 'pap-admin lp | grep -q SSL',
  }

  # Load the policy
  exec { 'apply argus policy':
    path => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => "sleep 60; pap-admin add-policies-from-file /etc/argus/argus_policy.xml; $restart_cmd",
    onlyif      => "bash -c \"[[ -r /etc/argus/argus_policy.xml ]] && pap-admin lp | grep -q 'No policies'\"",
    logoutput   => true, #"on_failure", # "true"
    require     => Exec['ssl restart']
  }

  # Load the policy
  exec { 'refresh argus policy':
    path => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => 'pap-admin add-policies-from-file /etc/argus/argus_policy.xml',
    refreshonly => true,
    logoutput   => true, #"on_failure", # "true"
    subscribe   => File['/etc/argus/argus_policy.xml'],
  }
        

}              
