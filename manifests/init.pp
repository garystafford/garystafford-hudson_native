# Class: hudson_native
#
# This module manages hudson_native
#
# Parameters:
# [*http_port*]
#   Optionally, start Hudson on port other than the default port of 8080.
#   Currenlty, only works for RHEL distros.
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#   include 'hudson_native'
#   class { 'hudson_native': }
#   class { 'hudson_native': http_port => 8094 }
#
class hudson_native ($http_port = 8080) {
  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'] }

  require java

  if $::osfamily == 'Debian' {
    exec { 'add-hudson-repo':
      command => 'sh -c "echo \'deb http://hudson-ci.org/debian /\' > /etc/apt/sources.list.d/hudson.list"',
      user    => root,
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    exec { 'update-apt-get':
      command => 'apt-get -yq update',
      user    => root,
      returns => [0, 100],
      onlyif  => 'test ! -f /etc/init.d/hudson'
    } ->
    exec { 'install-hudson':
      command => 'apt-get -o Dpkg::Options::="--force-confnew" -yq --force-yes install hudson',
      user    => root,
      returns => [0, 100],
      onlyif  => 'test ! -f /etc/init.d/hudson'
    }
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
    package { 'hudson': ensure => 'installed' } ->
    service { 'hudson':
      ensure => running,
      enable => true,
    }

    file_line { 'hudson-port-replace':
      path  => '/etc/sysconfig/hudson',
      line  => "HUDSON_PORT=${http_port}",
      match => '^HUDSON_PORT=',
    }

    file { '/etc/sysconfig/hudson': notify => Service['hudson'], }
  } else {
    notify { "Operating system ${::operatingsystem} not supported": }
  }
}
