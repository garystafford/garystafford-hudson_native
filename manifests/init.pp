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
class hudson_native ($http_port = 8080) {
  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'] }

  require java

  file { '/etc/profile.d/set_http_port.sh':
    ensure  => present,
    content => inline_template("HTTP_PORT=${http_port}")
  }

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
  } else {
    notify { "Operating system ${::operatingsystem} not supported": }
  }
}
