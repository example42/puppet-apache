class apache::install::tp (

  Variant[Boolean,String] $ensure           = present,
  Hash                    $confs            = { },
  Hash                    $dirs             = { },

) {

  include ::apache
  
  tp::install { 'apache':
    options_hash  => $::apache::options,
    settings_hash => $::apache::module_settings,
    data_module   => $::apache::data_module,
    conf_hash     => $confs,
    dir_hash      => $dirs,
    auto_conf     => $::apache::auto_conf,
  }

}
