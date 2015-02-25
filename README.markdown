# Hudson Native Installer #

Puppet module for installing Hudson CI using native Unix/Linux installation packages

## Support

This module is currently tested on:

* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 14.10
* CentOS 6.6

It may work on other distros...

## Usage

The module includes a single class:

```puppet
include 'hudson-native'
```

```puppet
class { 'hudson-native': }
```

## Test Install
`which hudson; hudson --version`


## Links
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_RPM
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_DEB
* http://wiki.eclipse.org/Hudson-ci/Using_Hudson/Installing_Hudson
* http://wiki.eclipse.org/Hudson-ci
