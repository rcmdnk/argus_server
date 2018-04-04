class argus_server::policy {

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
    command => '/usr/bin/systemctl restart argus-pap argus-pdp argus-pepd',
    onlyif  => '/usr/bin/pap-admin lp | grep -q SSL',
  }

  # Load the policy
  exec { 'apply argus policy':
    command     => '/usr/bin/sleep 60; /usr/bin/pap-admin add-policies-from-file /etc/argus/argus_policy.xml;/usr/bin/systemctl restart argus-pap argus-pdp argus-pepd',
    onlyif      => "/usr/bin/bash -c \"[[ -r /etc/argus/argus_policy.xml ]] && /usr/bin/pap-admin lp | grep -q 'No policies'\"",
    logoutput   => true, #"on_failure", # "true"
    require     => Exec['ssl restart']
  }

  # Load the policy
  exec { 'refresh argus policy':
    command     => '/usr/bin/pap-admin add-policies-from-file /etc/argus/argus_policy.xml',
    refreshonly => true,
    logoutput   => true, #"on_failure", # "true"
    subscribe   => File['/etc/argus/argus_policy.xml'],
  }
        

}              
