# Class apache::ssl
#
# Apache resources specific for SSL
#
class apache::ssl {

  include apache

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
      file { "${apache::config_dir}/ssl.conf":
        mode   => '0644',
        owner  => 'root',
        group  => 'root',
        notify => Service['apache'],
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

  ### Service monitoring, if enabled ( monitor => true )
  if ($apache::bool_monitor == true) and ($apache::sslport) {
    monitor::port { "apache_${apache::protocol}_${apache::sslport}":
      protocol => $apache::protocol,
      port     => $apache::sslport,
      target   => $apache::monitor_target,
      tool     => $apache::monitor_tool,
      enable   => $apache::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if ($apache::bool_firewall == true) and ($apache::sslport) {
    firewall { "apache_${apache::protocol}_${apache::sslport}":
      source      => $apache::firewall_src,
      destination => $apache::firewall_dst,
      protocol    => $apache::protocol,
      port        => $apache::sslport,
      action      => 'allow',
      direction   => 'input',
      tool        => $apache::firewall_tool,
      enable      => $apache::manage_firewall,
    }
  }


}
