# Class: hudson_native
#
# This module manages hudson_native
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class hudson_native {
  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'] }

  if $::osfamily == 'Debian' {
    exec { 'add-hudson-repo':
      command => 'sh -c \"echo \'deb http://hudson-ci.org/debian /\' > /etc/apt/sources.list.d/hudson.list\"',
      user    => root,
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    exec { 'update-apt-get':
      command => 'apt-get -y update',
      user    => root,
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    package { 'hudson': ensure => 'installed' }
  } elsif $::osfamily == 'RedHat' {
    exec { 'add-hudson-repo':
      command => 'wget -O /etc/yum.repos.d/hudson.repo http://hudson-ci.org/redhat/hudson.repo',
      user    => root,
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    exec { 'update-yum':
      command => 'yum -y check-update',
      user    => root,
      returns => [0, 100],
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    package { 'hudson': ensure => 'installed' }
  } else {
    notify { "Operating system ${::operatingsystem} not supported": }
  }
}
