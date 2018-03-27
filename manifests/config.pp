# Class: arc_ce
# Sets up the configuration file and file dependencies.
class argus_server::config {

  # ARGUS configuration files
  file { '/etc/argus/pap/pap-admin.properties':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/pap-admin.properties.erb"),
    notify  => Service['argus-pap'],
  }    

  file { '/etc/argus/pap/pap_configuration.ini':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/pap_configuration.ini.erb"),
    notify  => Service['argus-pap'],
  }    

  file { '/etc/argus/pdp/pdp.ini':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/pdp.ini.erb"),
    notify  => Service['argus-pdp'],
  }    

  file { '/etc/argus/pepd/pepd.ini':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/pepd.ini.erb"),
    notify  => Service['argus-pepd'],
  }    

  # XML policy to load
  file { '/etc/argus/argus_policy.xml':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/argus_policy.erb"),
  }
  # Cleanup the policy before loading it
  exec { 'remove_argus_policy':
    command     => '/usr/bin/pap-admin remove-all-policies',
    refreshonly => !$force_reload,
    logoutput   => true, #"on_failure", # "true"
    subscribe   => File['/etc/argus/argus_policy.xml'],
  }

  # Load the policy
  exec { 'apply_argus_policy':
    command     => '/usr/bin/pap-admin add-policies-from-file /etc/argus/argus_policy.xml',
    refreshonly => true,
    logoutput   => true, #"on_failure", # "true"
    subscribe   => Exec['remove_argus_policy'],
  }
}
