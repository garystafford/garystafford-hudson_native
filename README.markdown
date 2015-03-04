# Hudson Native Installer #

Puppet module for installing Hudson CI using native Unix/Linux installation packages. 
Hudson runs within a JVM, and therefore requires Java be installed. 
This module has a dependency on the `puppetlabs-java` module.
  
[![Hudson Initial View](https://github.com/garystafford/garystafford-hudson_native/blob/master/images/HudsonCIServerInitialSetup_preview.png?raw=true)](https://github.com/garystafford/garystafford-hudson_native/blob/master/images/HudsonCIServerInitialSetup.png?raw=true)
[![Hudson Up and Running](https://github.com/garystafford/garystafford-hudson_native/blob/master/images/HudsonUpandRunning_preview.png?raw=true)](https://github.com/garystafford/garystafford-hudson_native/blob/master/images/HudsonUpandRunning.png?raw=true)
  
## Support

This module is currently tested on:
* CentOS 6.5
* CentOS 6.6
* Ubuntu 14.04.02 LTS

Will work on other Debian/RHEL distros. Needs to be tested.

## Usage

The module includes a single `hudson_native` class. 
The `http_port` parameter allows you to optionally 
start Hudson on port other than the default port of 8080. 
Currenlty, `http_port` requires a manual restart of the Hudson service to 
switch from default port of 8080 to new port.

```
include 'hudson_native'  
class { 'hudson_native': }  
class { 'hudson_native': http_port => 8094 }
```

## Test Install of Java and Hudson
  
`java -version`  
should return a result similar to  
`OpenJDK Runtime Environment (rhel-2.5.4.0.el6_6-x86_64 u75-b13)`  
`OpenJDK 64-Bit Server VM (build 24.75-b04, mixed mode)`
    
`sudo netstat -tulpn | grep 8080`  
should return a result similar to  
`tcp 0 0 :::8080 :::* LISTEN 12697/java`  
  
`sudo service hudson status` or  
`sudo /etc/init.d/hudson status`  
should return a result similar to  
`hudson (pid 13276) is running...`  

## Hudson Links
* http://wiki.eclipse.org/Hudson-ci
* http://wiki.eclipse.org/Hudson-ci/Using_Hudson/Installing_Hudson
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_RPM
* http://wiki.eclipse.org/Hudson-ci/Installing_Hudson_DEB

## Other Useful Commands
* `sudo cat /var/log/hudson/hudson.log # hudson log`
* `cat /etc/default/hudson # defaults for hudson when running`
* `ls -l /etc/init.d/`
* `cat /etc/services`