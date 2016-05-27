# Class: apache
# ===========================
#
# This module install and configures apache.
# This main class just manages a basic installation.
# For configurations for different use cases check the classes
# in the profile directory.
#
class apache (

  String     $ensure        = 'present',
  String     $install_class = '::apache::install::tp',

  Hash       $options       = { },
  Hash       $settings      = { },

  String[1]  $data_module   = 'apache',

  Boolean    $auto_restart  = true,
  Boolean    $auto_conf     = false,
  Boolean    $auto_depend   = true,

) {

  $tp_settings = tp_lookup('apache','settings',$data_module,'merge')
  $real_settings = $tp_settings + $settings
  if $real_settings['service_name'] and $auto_restart {
    $service_notify = "Service[${real_settings['service_name']}]"
  } else {
    $service_notify = undef
  }

  if $install_class != '' {
    include $install_class
  }

}
