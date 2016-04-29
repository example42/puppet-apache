define apache::module (
  Variant[Boolean,String] $ensure           = present,

  Variant[Undef,String]   $template         = undef,
  Hash                    $options          = { },

  Boolean                 $package_install  = false,
  String[1]               $package_name     = false,
) {

  include ::apache

  if $template {
    tp::conf { "apache::module::${title}":
      base_dir           => 'mod',
      template           => $template,
      options_hash       => $::apache::options + $options,
      data_module        => $::apache::data_module,
      settings           => $::apache::module_settings,
      config_file_notify => $::apache::service_autorestart,
    }
  }

  if $install_package {
    $real_package_name = $install_package ? {
      true    => "${::apache::settings['modpackage_prefix']}${name}",
      default => $install_package,
    }

    package { $real_package_name:
      ensure  => $ensure,
    }
  }

  if $::osfamily == 'Debian' {
    case $ensure {
      'present': {

        $exec_a2enmod_subscribe = $install_package ? {
          false   => undef,
          default => Package[$real_package_name]
        }
        $exec_a2dismode_before = $install_package ? {
          false   => undef,
          default => Package[$real_package_name]
        }

        exec { "/usr/sbin/a2enmod ${name}":
          unless    => "/bin/sh -c '[ -L ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load ] && [ ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load -ef ${::apache::settings['config_dir_path']}/mods-available/${name}.load ]'",
          # notify    => $manage_service_autorestart,
          # require   => Package['apache'],
          subscribe => $exec_a2enmod_subscribe,
        }
      }
      'absent': {
        exec { "/usr/sbin/a2dismod ${name}":
          onlyif    => "/bin/sh -c '[ -L ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load ] && [ ${::apache::settings['config_dir_path']}/mods-enabled/${name}.load -ef ${::apache::settings['config_dir_path']}/mods-available/${name}.load ]'",
          # notify    => $manage_service_autorestart,
          # require   => Package['apache'],
          before    => $exec_a2dismode_before,
        }
      }
      default: {
      }
    }
  }



}
