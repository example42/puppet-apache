# Class: apache::params
#
# This class defines default parameters used by the main module class apache
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to apache class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class apache::params {

  ### Application specific parameters
  $package_modssl = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'libapache-mod-ssl',
    /(?i:SLES|OpenSuSE)/      => undef,
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '11'                    => 'web/server/apache-24/module/apache-ssl',
    },
    default                   => 'mod_ssl',
  }

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'apache2',
    /(?i:SLES|OpenSuSE)/      => 'apache2',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => 'apache24',
      '11'                    => 'web/server/apache-24',
    },
    default                   => 'httpd',
  }

  $service = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'apache2',
    /(?i:SLES|OpenSuSE)/      => 'apache2',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => 'svc:/network/cswapache24:default',
      '11'                    => 'svc:/network/http:apache24',
    },
    default                   => 'httpd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'apache2',
    /(?i:SLES|OpenSuSE)/      => 'httpd2-prefork',
    default                   => 'httpd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'www-data',
    /(?i:SLES|OpenSuSE)/      => 'wwwrun',
    /(?i:Solaris)/            => 'webservd',
    default                   => 'apache',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/etc/apache2',
    /(?i:SLES|OpenSuSE)/      => '/etc/apache2',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => '/etc/apache2',
      '11'                    => '/etc/apache2/2.4',
    },
    freebsd                   => '/usr/local/etc/apache20',
    default                   => '/etc/httpd',
  }

  $config_file = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/etc/apache2/apache2.conf',
    /(?i:SLES|OpenSuSE)/      => '/etc/apache2/httpd.conf',
    /(?i:Solaris)/            => "${config_dir}/httpd.conf",
    freebsd                   => '/usr/local/etc/apache20/httpd.conf',
    default                   => '/etc/httpd/conf/httpd.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    freebsd => 'wheel',
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/apache2',
    /(?i:SLES|OpenSuSE)/      => '/etc/sysconfig/apache2',
    /(?i:Solaris)/            => undef,
    default                   => '/etc/sysconfig/httpd',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/run/apache2.pid',
    /(?i:SLES|OpenSuSE)/      => '/var/run/httpd2.pid',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => '/var/run/apache2/httpd.pid',
      '11'                    => '/usr/apache2/2.4/httpd.pid',
    },
    default                   => '/var/run/httpd.pid',
  }

  $log_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/apache2',
    /(?i:SLES|OpenSuSE)/      => '/var/log/apache2',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => '/var/apache2/logs',
      '11'                    => '/var/apache2/2.4/logs',
    },
    default                   => '/var/log/httpd',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => ['/var/log/apache2/access.log','/var/log/apache2/error.log'],
    /(?i:SLES|OpenSuSE)/      => ['/var/log/apache2/access.log','/var/log/apache2/error.log'],
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => ['/var/apache2/logs/access.log','/var/apache2/logs/error.log'],
      '11'                    => ['/var/apache2/2.4/logs/access.log', '/var/apache2/2.4/logs/error.log'],
    },
    default                   => ['/var/log/httpd/access.log','/var/log/httpd/error.log'],
  }

  $data_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/www',
    /(?i:Suse|OpenSuse)/      => '/srv/www/htdocs',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => '/var/apache2/htdocs',
      '11'                    => '/var/apache2/2.4/htdocs',
    },
    default                   => '/var/www/html',
  }

  $ports_conf_path = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/apache2/ports.conf',
    default                   => '',
  }

  $port = '80'
  $ssl_port = '443'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $config_file_default_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $service_requires = Package['apache']
  $absent = false
  $version = ''
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $dotconf_hash = {}
  $htpasswd_hash = {}
  $listen_hash = {}
  $module_hash = {}
  $vhost_hash = {}
  $virtualhost_hash = {}

}
