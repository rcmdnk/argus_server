# Class: arc_ce
# Sets up the configuration file and file dependencies.
class argus_server::config (
  $hostcert = false,
  $hostkey = false,
){

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

  if $hostcert {
    file { '/etc/grid-security/hostcert.pem':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      source  => $hostcert,
    }
  }
  if $hostkey {
    file { '/etc/grid-security/hostkey.pem':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => $hostkey,
    }
  }
}
