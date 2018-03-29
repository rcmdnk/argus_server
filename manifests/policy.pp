class argus_server::policy {

  # Restart argus if needed
  exec {'restart argus':
    command => '/usr/bin/systemctl restart argus-pap argus-pdp argus-pepd',
    onlyif  => '/usr/bin/pap-admin lp | grep -q SSL',
  }

  # XML policy to load
  file { '/etc/argus/argus_policy.xml':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/argus_policy.erb"),
    require => Exec['restart argus']
  }

  # Load the policy
  exec { 'apply argus policy':
    command     => '/usr/bin/pap-admin add-policies-from-file /etc/argus/argus_policy.xml',
    refreshonly => true,
    logoutput   => true, #"on_failure", # "true"
    subscribe   => File['/etc/argus/argus_policy.xml'],
    require     => Exec['restart argus'],  
  }
}              
