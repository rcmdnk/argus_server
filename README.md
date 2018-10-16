# Puppet Module for Argus Server #

Documentation
=========================
https://www.gridpp.ac.uk/wiki/Argus_Server
https://twiki.cern.ch/twiki/pub/EMI/ArgusEMIDocumentation/EMI-Argus-SysAdminGuide-1.1.0.pdf

Requirements
=========================
- Requires the host certificate and key to be set up in /etc/grid-security/hostcert.pem and /etc/grid-security/hostkey.pem
- Scientific Linux 6.X
- puppet-fetchrl (https://github.com/voxpupuli/puppet-fetchcrl)
- puppet-voms_client (https://github.com/HEP-Puppet/puppet-voms_client)
- puppet-localfolder (https://github.com/HEP-Puppet/puppet-localfolder)
- puppet-grid_accounts (https://github.com/HEP-Puppet/puppet-grid_accounts)

Features
=========================
- Installs the EGI IGTF trust anchors
- Installs fetch-crl (from the EPEL repository), runs it once, and enables the cron job
- Installs EMI Argus server
