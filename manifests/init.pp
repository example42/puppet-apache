class apache (

  Variant[Boolean,String] $ensure           = present,

  Hash                    $confs            = { },
  Hash                    $dirs             = { },

  Hash                    $options          = { },
  Hash                    $settings         = { },

  Array                   $profiles         = [],

  String[1]               $data_module      = 'apache',

  Boolean                 $service_autorestart = true,
  Boolean                 $auto_conf        = false,

) {

  $tp_settings = tp_lookup('apache','settings',$data_module,'merge')
  $module_settings = $tp_settings + $settings

  tp::install { 'apache':
    options_hash  => $options,
    settings_hash => $module_settings, 
    data_module   => $data_module,  
    conf_hash     => $confs,
    dir_hash      => $dirs,
    auto_conf     => $auto_conf,
  }

  if $profiles != [] {
    $profiles.each |$kl| {
      include $kl
    }
  }

}
