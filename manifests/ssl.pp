# Class apache::ssl
#
# Apache resources specific for SSL
#
class apache::ssl (
  $ssl_port            = params_lookup( 'ssl_port' ),
  $ssl_source          = params_lookup( 'ssl_source' ),
  $ssl_template        = params_lookup( 'ssl_template' ),
  ) inherits apache::params {

  include apache

  $manage_ssl_file_source = $apache::ssl::ssl_source ? {
    '' => undef,
    default => $apache::ssl::ssl_source,
  }

  $manage_ssl_file_content = $apache::ssl::ssl_template ? {
    '' => undef,
    default => template($apache::ssl::ssl_template),
  }

  case $::operatingsystem {
    ubuntu,debian,mint: {
      exec { 'enable-ssl':
        command => '/usr/sbin/a2enmod ssl',
        creates => '/etc/apache2/mods-enabled/ssl.load',
        notify  => Service['apache'],
        require => Package['apache'],
      }
    }

    default: {
      package { 'mod_ssl':
        ensure  => present,
        require => Package['apache'],
        notify  => Service['apache'],
      }
      file { 'ssl.conf':
        ensure => $apache::manage_file,
        path => "${apache::ssl::dotconf_dir}/ssl.conf",
        mode => $apache::config_file_mode,
        owner => $apache::config_file_owner,
        group => $apache::config_file_group,
        require => Package['mod_ssl'],
        notify => $apache::manage_service_autorestart,
        source => $apache::ssl::manage_ssl_file_source,
        content => $apache::ssl::manage_ssl_file_content,
        replace => $apache::manage_file_replace,
        audit => $apache::manage_audit,
      }
      file {['/var/cache/mod_ssl', '/var/cache/mod_ssl/scache']:
        ensure  => directory,
        owner   => 'apache',
        group   => 'root',
        mode    => '0700',
        require => Package['mod_ssl'],
        notify  => Service['apache'],
      }
    }
  }

  ### Port monitoring, if enabled ( monitor => true )
  if $apache::bool_monitor == true {
    monitor::port { "apache_${apache::protocol}_${apache::ssl::ssl_port}":
      protocol => $apache::protocol,
      port     => $apache::ssl::ssl_port,
      target   => $apache::monitor_target,
      tool     => $apache::monitor_tool,
      enable   => $apache::manage_monitor,
    }
  }

  ### Firewall management, if enabled ( firewall => true )
  if $apache::bool_firewall == true {
    firewall { "apache_${apache::protocol}_${apache::ssl::ssl_port}":
      source      => $apache::firewall_src,
      destination => $apache::firewall_dst,
      protocol    => $apache::protocol,
      port        => $apache::ssl::ssl_port,
      action      => 'allow',
      direction   => 'input',
      tool        => $apache::firewall_tool,
      enable      => $apache::manage_firewall,
    }
  }

}
