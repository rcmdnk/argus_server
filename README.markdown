# Puppet Module for Argus Server #

This is the argus module, it installs the argus service. The argus service to work needs other modules.

* puppet-fetchrl (https://github.com/voxpupuli/puppet-fetchcrl)
* puppet-voms_client (https://github.com/HEP-Puppet/puppet-voms_client)
* puppet-localfolder (https://github.com/HEP-Puppet/puppet-localfolder)
* puppet-grid_accounts (https://github.com/HEP-Puppet/puppet-grid_accounts)

or at any rate similar modules that create the gridmapfiles and dir, voms client and handles hostcertificates.

## Configuration

An example of hiera configuration, including an array of policies, is in the example.

### License
ASL 2.0
=======
Documentation
=========================
https://www.gridpp.ac.uk/wiki/Argus_Server
https://twiki.cern.ch/twiki/pub/EMI/ArgusEMIDocumentation/EMI-Argus-SysAdminGuide-1.1.0.pdf

Requirements
=========================
- Requires the host certificate and key to be set up in /etc/grid-security/hostcert.pem and /etc/grid-security/hostkey.pem
- Scientific Linux 6.X

Features
=========================
- Installs the EGI IGTF trust anchors
- Installs fetch-crl (from the EPEL repository), runs it once, and enables the cron job
- Installs EMI Argus server
