# Class apache::passenger
#
# Apache resources specific for passenger
#
class apache::passenger {
  include apache

  case $::operatingsystem {
    ubuntu, debian, mint : {
      package { 'libapache2-mod-passenger': ensure => present; }

      exec { 'enable-passenger':
        command => '/usr/sbin/a2enmod passenger',
        creates => '/etc/apache2/mods-enabled/passenger.load',
        notify  => Service['apache'],
        require => [Package['apache'], Package['libapache2-mod-passenger']],
      }
    }

    centos, redhat, scientific, fedora : {
      $osver = split($::operatingsystemrelease, '[.]')

      case $osver[0] {
        5       : {
          require yum::repo::passenger

          package { 'mod_passenger': ensure => present; }
        }
        7       : {
          $version = '5.0.15'
          $build_tools = ["gcc-c++", "libcurl-devel", "openssl-devel", "zlib-devel", "httpd-devel", "apr-devel", 'apr-util-devel']

          if !defined(Class['::ruby::dev']) {
            class { '::ruby::dev': }
          }

          package { $build_tools: } ->
          package { 'passenger': provider => gem, ensure => $version } 
          exec { 'install_passenger_modules':
            command => '/usr/local/bin/passenger-install-apache2-module -a',
            require => [Package['passenger'], Class['ruby::dev']],
            creates => "/usr/local/share/gems/gems/passenger-${version}/buildout/apache2/mod_passenger.so"
          } ->
          exec { 'create_passenger_conf':
            command => '/usr/local/bin/passenger-install-apache2-module --snippet > /etc/httpd/conf.modules.d/00-passenger.conf',
            creates => '/etc/httpd/conf.modules.d/00-passenger.conf',
            notify  => Service['httpd']
          }
        }
        default : {
          package { 'mod_passenger': ensure => present; }
        }
      }
    }

    default              : {
    }
  }

}
