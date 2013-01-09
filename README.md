# check_mk puppet module

## Overview

Installs check_mk-agent and optionally configures the firewall.  If 
installing on RHEL/CentOS you can optionally specify a URL to the
RPM you'd like to install.

### class check_mk

Parameters:

* manage_firewall - Set to true if you want this module to open the ports needed for check_mk-agent. (Requires the firewall module, Default: False)
* package_url - Optionally define the URL where the RPM containing check_mk-agent is located (RHEL/CentOS only - requires RPM provider)

Examples:

    class { 'check_mk':
      manage_firewall => True,
      package_url     => 'http://mathias-kettner.de/download/check_mk-agent-1.2.0p3-1.noarch.rpm',
    }

## Supported Platforms

This class has only been fully tested on RHEL6.  It should work on Ubuntu,
though you may encounter issues with firewall management (if you enable it).
