# argus #

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
