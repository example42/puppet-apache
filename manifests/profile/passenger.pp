class apache::profile::passenger (
  Variant[Boolean,String]  $ensure           = present,
  Hash                     $options          = { },
  Variant[Undef,String[1]] $template         = undef,
) {

  include apache

  if $template {
    tp::conf { 'apache::passenger':
      base_dir           => 'conf',
      template           => $template,
      options_hash       => $::apache::options + $options,
      data_module        => $::apache::data_module,
      settings_hash      => $::apache::module_settings,
      config_file_notify => $::apache::service_autorestart,
    }
  }

  package { $::apache::module_settings['passenger_package_name']:
    ensure => $ensure,
  }

  if $::osfamily == 'Debian' {
    exec { 'enable-passenger':
      command => '/usr/sbin/a2enmod passenger',
      creates => '/etc/apache2/mods-enabled/passenger.load',
      notify  => $::apache::module_settings['service_name'],
      require => [
        $::apache::module_settings['package_name'],
        $::apache::module_settings['passenger_package_name']
      ],
    }
  }

}
