define apache::module (
  Variant[Boolean,String]    $ensure           = '',

  Variant[Undef,String]      $template         = undef,
  Hash                       $options          = { },

  Boolean                    $package_install  = false,
  Variant[Boolean,String[1]] $package_name     = false,
) {

  include ::apache

  if $template {
    tp::conf { "apache::module::${title}":
      ensure             => $ensure,
      base_dir           => 'mod',
      template           => $template,
      options_hash       => $::apache::options + $options,
      data_module        => $::apache::data_module,
      settings           => $::apache::real_settings,
      config_file_notify => $::apache::service_notify,
    }
  }

  if $package_install {
    $real_package_name = $package_install ? {
      true    => "${::apache::real_settings['modpackage_prefix']}${name}",
      default => $package_install,
    }

    package { $real_package_name:
      ensure => $ensure,
      notify => $::apache::service_notify,
    }
  }

  if $::osfamily == 'Debian' {
    case $ensure {
      'present': {

        $exec_a2enmod_subscribe = $package_install ? {
          false   => undef,
          default => Package[$real_package_name]
        }
        $exec_a2dismode_before = $package_install ? {
          false   => undef,
          default => Package[$real_package_name]
        }

        exec { "/usr/sbin/a2enmod ${name}":
          unless    => "/bin/sh -c '[ -L ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load ] && [ ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load -ef ${::apache::settings['config_dir_path']}/mods-available/${name}.load ]'",
          notify    => $::apache::service_notify,
          require   => Package[$::apache::real_settings['package_name']],
        }
      }
      'absent': {
        exec { "/usr/sbin/a2dismod ${name}":
          onlyif    => "/bin/sh -c '[ -L ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load ] && [ ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load -ef ${::apache::settings['config_dir_path']}/mods-available/${name}.load ]'",
          notify    => $::apache::service_notify,
          require   => Package[$::apache::real_settings['package_name']],
          before    => $exec_a2dismode_before,
        }
      }
      default: {
      }
    }
  }

}
