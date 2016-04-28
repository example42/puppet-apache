class apache (

  Variant[Boolean,String] $ensure           = present,

  Hash                    $confs            = { },
  Hash                    $dirs             = { },

  Hash                    $options          = { },
  Hash                    $settings         = { },

  Array                   $profiles         = [],

  String[1]               $data_module      = 'apache',

) {

  tp::install { 'apache':
    options_hash  => $options,
    settings_hash => $settings, 
    data_module   => $data_module,  
    conf_hash     => $confs,
    dir_hash      => $dirs,
  }

  if $profiles != [] {
    $profiles.each |$kl| {
      include $kl
    }
  }

}
