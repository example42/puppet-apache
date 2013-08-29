# = Define: apache::ports
#
# This define configures apache listen port on Debian / Ubuntu OS
# On Debian and derivatives it places the config
# into /etc/apache2/ports.conf
# On RedHat and derivatives don't do nothing (FIXME)
#
# == Parameters
#
#
# [*templatefile*]
#   Optional. Location of the template to use to configure
#   the module
#
# [*notify_service*]
#   If you want to restart the apache service automatically when
#   the module is applied. Default: true
#
# == Examples
# apache::ports { '8080':}
#
define apache::ports (
  $ensure          = 'present',
  $templatefile    = 'apache/ports.conf.erb',
  $notify_service  = true ) {

  include apache

  $manage_service_autorestart = $notify_service ? {
    true    => 'Service[apache]',
    false   => undef,
  }

  if $::operatingsystem == 'Debian'
  or $::operatingsystem == 'Ubuntu'
  or $::operatingsystem == 'Mint' {

  file { "ApachePorts_${name}_conf":
      ensure  => present ,
      path    => $apache::ports_conf_path,
      mode    => $apache::config_file_mode,
      owner   => $apache::config_file_owner,
      group   => $apache::config_file_group,
      content => template($templatefile),
      notify  => $manage_service_autorestart,
      require => Package['apache'],
    }
	
      }
}
