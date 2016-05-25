class apache (

  Variant[Boolean,String] $ensure           = present,
  String                  $install_class    = '::apache::install::tp',

  Hash                    $options          = { },
  Hash                    $settings         = { },

  Array                   $profiles         = [],

  String[1]               $data_module      = 'apache',

  Boolean                 $auto_restart     = true,
  Boolean                 $auto_conf        = false,
  Boolean                 $auto_prerequisites = true,

) {

  $tp_settings = tp_lookup('apache','settings',$data_module,'merge')
  $module_settings = $tp_settings + $settings
  if $module_settings['service_name'] and $auto_restart {
    $service_notify = "Service[${module_settings['service_name']}]"
  } else {
    $service_notify = undef
  }

  if $install_class != '' {
    include $install_class
  }

  if $profiles != [] {
    $profiles.each |$kl| {
      include "::apache::profile::${kl}"
    }
  }

}
