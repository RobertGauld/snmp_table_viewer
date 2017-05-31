[![Gem Version](https://badge.fury.io/rb/snmp-table-viewer.svg)](http://badge.fury.io/rb/snmp-table-viewer)
[![Dependency Status](https://gemnasium.com/robertgauld/snmp-table-viewer.png)](https://gemnasium.com/robertgauld/snmp-table-viewer)

Master branch:
[![Build Status](https://secure.travis-ci.org/robertgauld/snmp-table-viewer.png?branch=master)](http://travis-ci.org/robertgauld/snmp-table-viewer)
[![Coveralls Status](https://coveralls.io/repos/robertgauld/snmp-table-viewer/badge.svg?branch=master)](https://coveralls.io/r/robertgauld/snmp-table-viewer)
[![Code Climate](https://codeclimate.com/github/robertgauld/snmp-table-viewer.png?branch=master)](https://codeclimate.com/github/robertgauld/snmp-table-viewer)

Staging branch:
[![Build Status](https://secure.travis-ci.org/robertgauld/snmp-table-viewer.png?branch=staging)](http://travis-ci.org/robertgauld/snmp-table-viewer)
[![Coveralls Status](https://coveralls.io/repos/robertgauld/snmp-table-viewer/badge.svg?branch=master)](https://coveralls.io/r/robertgauld/snmp-table-viewer)
[![Code Climate](https://codeclimate.com/github/robertgauld/snmp-table-viewer.png?branch=staging)](https://codeclimate.com/github/robertgauld/snmp-table-viewer)


## Build State
This project uses continuous integration to help ensure that a quality product is delivered.
Travis CI monitors two branches (versions) of the code - Master (which is what gets released)
and Staging (which is what is currently being developed ready for moving to master).


## Ruby Versions
This gem supports the following versions of ruby, it may work on other versions but is not tested against them so don't rely on it.

  * 2.3.0
  * 2.3.1
  * 2.4.0


## SNMP Table Viewer

Easily view SNMP tables. The data in the table can be easily converted and formatted in a number of ways.


## Installation

Add to your Gemfile and run the `bundle` command to install it.

```ruby
gem 'snmp-view-table', '~> 0.0'
```


## Executable

```
Usage: snmp-table-viewer [options]
    -h, -?, --help                   Prints this help.
        --headings HEADINGS          Headings to use in the table (e.g. "A, Bc, D").
        --headings-for TYPE          Use headings for this table type (ifTable).
        --format FORMAT              How to format the output (table|csv|json|raw) (default table).
        --converter CONVERTER        A converter to run on the data before formatting (iftable).

SNMP common options:
    -v, --version VERSION            SNMP version to use (1|2|3|) (default 3).
        --host HOST                  The host to connect to.
        --port PORT                  p PORT
                                     SNMP port to connect to (default 161).
        --base-oid OID               The oid at the start of the table. Can by dotted numbers or ifTable

SNMP version 1 and 2 options:
    -c, --comunity COMMUNITY         SNMP comunity (default "public").

SNMP version 3 options:
    -u, --user, --username USER      SNMP user.
        --security-level LEVEL       l LEVEL
                                     Security level to use (??|auth_priv).
    -a AUTH_PROTOCOL,                Authentication protocol to use (MD5|SHA) (default MD5).
        --auth-protocol
    -A AUTH_PASSWORD,                Authentication password to use.
        --auth-password
    -x PRIV_PROTOCOL,                Privacy protocol to use (DES|AES) (default DES).
        --priv-protocol
    -X PRIV_PASSWORD,                Privacy password to use.
        --priv-password

Table formatter options:
        --[no-]transpose-table       Transpose the output table (swap rows and columns).
```

## Documentation & Versioning

Documentation can be found on [rubydoc.info](http://rubydoc.info/github/robertgauld/snmp-table-viewer/master/frames)

We follow the [Semantic Versioning](http://semver.org/) concept,
