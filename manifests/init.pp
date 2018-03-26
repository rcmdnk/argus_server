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
  $argus_host = '',
  $argus_host_dn = '',
  $centralban_enabled = 'false',
  $centralban_host = 'argusngi.gridpp.rl.ac.uk',
  $centralban_dn = '/C=UK/O=eScience/OU=CLRC/L=RAL/CN=argusngi.gridpp.rl.ac.uk',
  $packages = ['java-1.8.0-openjdk', 'argus-authz', 'bdii', 'glite-info-provider-service'],
  
){
  
  class { 'argus_server::install': }
  class { 'argus_server::config': }
  class { 'argus_server::services': }

}
