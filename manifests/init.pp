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
  $packages = ['java-1.8.0-openjdk', 'argus-authz', 'bdii', 'glite-info-provider-service'],
  $argus_host = '',
  $argus_host_dn = '',
  $pap_poll_interval = 3600,
  $pdp_retention_interval = 240,  
  $pap_policy = {},
  $centralban_enabled = 'false',
  $centralban_host = 'argusngi.gridpp.rl.ac.uk',
  $centralban_dn = '/C=UK/O=eScience/OU=CLRC/L=RAL/CN=argusngi.gridpp.rl.ac.uk',
){
  
  class { 'argus_server::repositories': }
  class { 'argus_server::install': }
  class { 'argus_server::config': }
  class { 'argus_server::services': }
  class { 'argus_server::policy': }
  Class['argus_server::repositories'] ->  Class['argus_server::install'] -> Class['argus_server::config'] -> Class['argus_server::services'] -> Class['argus_server::policy']
}
