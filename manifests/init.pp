# Class: argus
#
# This module manages argus
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class argus_server (
  $argus_host_dn,
  $admin_password,
  $argus_host             = $::fqdn,
  $packages               = ['java-1.8.0-openjdk', 'argus-authz', 'bdii', 'glite-info-provider-service'],
  $pap_poll_interval      = 3600,
  $pdp_retention_interval = 240,
  $pap_policy             = {},
  $centralban_enabled     = false,
  $centralban_host        = 'argusngi.gridpp.rl.ac.uk',
  $centralban_dn          = '/C=UK/O=eScience/OU=CLRC/L=RAL/CN=argusngi.gridpp.rl.ac.uk',
  $servicecert            = '/etc/grid-security/hostcert.pem',
  $servicekey             = '/etc/grid-security/hostkey.pem',
){

  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['release']['major'] {
        '6': { $restart_cmd = '/sbin/service argus-pap restart; /sbin/service argus-pdp restart; /sbin/service argus-pepd restart' }
        default: { $restart_cmd = '/usr/bin/systemctl restart argus-pap argus-pdp argus-pepd' }
      }
    }
    default: {
      fail("OS family ${facts['os']['family']} is not supported by this module")
    }
  }

  class { 'argus_server::install': }
  class { 'argus_server::config': }
  class { 'argus_server::services': }
  class { 'argus_server::policy': }
  Class['argus_server::install'] -> Class['argus_server::config'] -> Class['argus_server::services'] -> Class['argus_server::policy']
}
