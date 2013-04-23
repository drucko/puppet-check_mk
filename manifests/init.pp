# == Class: check_mk
#
# Installs and configures the check_mk package on RHEL and Ubuntu
#
# === Parameters
#
# [*manage_firewall*]
#   Set to true if you want this module to open the ports needed for check_mk
#   (default: False)
# [*package_url*]
#   RHEL Only: Set the URL of the check_mk RPM to install
#
# === Examples
#
#  class { check_mk:
#    manage_firewall => True,
#    package_url     => "http://mathias-kettner.de/download/check_mk-agent-1.2.0p3-1.noarch.rpm"
#  }
#
# === Authors
#
# Phil Fenstermacher <pcfens@wm.edu>
#
class check_mk (
  $package_url = 'http://mathias-kettner.de/download/check_mk-agent-1.2.0p3-1.noarch.rpm',
  $manage_firewall = False,
  $port = 6556,
  $firewall_src = '0.0.0.0/0',
  $allowed_hosts = 'unset',
){

  if $check_mk::manage_firewall != False {
    firewall { '050 allow check_mk':
      dport  => $check_mk::port,
      source => $check_mk::firewall_src,
      action => 'accept',
      proto  => 'tcp',
    }
  }

  case $::operatingsystem {
    'RedHat': {

      package { 'xinetd':
        ensure => latest,
      }

      package { 'check_mk-agent':
        ensure   => latest,
        provider => 'rpm',
        require  => Package['xinetd'],
        source   => $check_mk::package_url,
      }

    }
    'Ubuntu': {
      package { 'check-mk-agent':
        ensure => latest,
      }
    }

    default: {
      notify {'Cannot install check_mk':
        message => 'Cannot install check_mk on this operating system with this module',
      }
    }

  }
}
