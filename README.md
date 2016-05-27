#### Table of Contents

1. [Overview](#overview)
2. [Module Descriptionl](#module-description)
3. [Setup](#setup)
    * [What apache affects](#what-apache-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with apache](#beginning-with-apache)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

This module installs and configures apache.

It is compatible only with Puppet version 4 or newer.

## Module Description


## Setup

### What apache affects

* Installation of apache package and eventual management of its service
* Creation of configuration files for apache
* Different profiles for different use cases

### Setup Requirements

This module needs the following prerequisites modules:

  - puppetlabs-stdlib
  - example42-tp

### Beginning with apache

To simply install apache without any configuration just:

    include ::apache

To install one of the profiles of this module (they have their own parameters and require the main class.

    include ::apache::profile::<profile_name>

    To manage a configuration file (in the conf.d directory):
    
    apache::conf { 'example':
      template => 'site/apache/example.conf.erb',
      options  => hiera('apache::conf::example::options'),
    }

## Usage

The module's common paramateres entry point is the main class, which is included by all the profiles and defines.

The most important parameters (here written as configurable via Hiera with Yaml backend, you can obviously pass them when declaring the apache class):

    # Manage installation or removal
    apache::ensure: present # Default

    # Define what class to use to install apache
    apache::install_class: '::apache::install::tp' # Default installation via Tiny Puppet

    # Override the settings defined in the module's data
    # Default is an empty hash, here an example to override the url of the repo and the GPG key to use
    apache::settings:
      repo_url: 'http://packages.example.com'
      key_url: 'http://packages.example.com/gpg'

    # Set any option you may want to use in templates
    apache::options:
      my_key: my_value # In an erb template this is accessed with \<\%= @options['my_key'] \%\>

    # Define what module to use for Tiny Puppet data:
    apache::data_module: apache # Default

    # Restart service on change, by default, on all the module's classes and defines
    apache::auto_restart: true # Default 

    # Automatically add, in the main class and profiles, default configurations, if they are available
    apache::auto_conf: false # Default 

    # Automatically add prerequisites resources (packages, repos, users...) if they are defined
    apache::auto_depend: false # Default 


## Reference

### class apache

Check [Usage](#usage) section.


## Limitations

This module works only with Puppet version 4 or later.

It supports the following Operating Systems:

  - RedHat and derivatives: 5, 6, 7
  - Debian 7, 8
  - Ubuntu 12.04, 14.04, 16.04


## Development

Development of these done is done by commission of sponsor companies or by necessity.

Check the [CONTRIBUTING](./github/CONTRIBUTING.md) document for more informations on how to contribute.
