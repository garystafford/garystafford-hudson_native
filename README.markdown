# Hudson Native Installer #

Puppet module for installing Hudson CI using native Unix/Linux installation packages. 
Hudson runs in a JVM, and requires Java be installed. 
I suggest using the `puppetlabs-java` module.


## Support

This module is currently tested on:
* CentOS 6.6 (working now)
* Ubuntu 12.04 (coming soon - TODO)
* Ubuntu 14.04 (coming soon - TODO)
* Ubuntu 14.10 (coming soon - TODO)

It may work on other distros. Needs to be tested.

## Usage

The module includes a single class:

```puppet
include 'hudson-native'
```

```puppet
class { 'hudson-native': }
```

## Test Install
`sudo service hudson status` or `sudo /etc/init.d/hudson status`
should return a result similar to  
`hudson (pid 13276 13248 12690) is running...`  
  
`sudo netstat -tulpn | grep 8080`  
should return a result similar to  
`tcp 0 0 :::8080 :::* LISTEN 12697/java`

## Links
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_RPM
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_DEB
* http://wiki.eclipse.org/Hudson-ci/Using_Hudson/Installing_Hudson
* http://wiki.eclipse.org/Hudson-ci

## Useful Commands
* ls -l /etc/init.d/ 
* cat /etc/services