class apache::install::tp (

  String $ensure = '',
  Hash   $confs  = { },
  Hash   $dirs   = { },

) {

  include ::apache
  
  tp::install { 'apache':
    ensure        => pick($ensure,$::apache::ensure),
    options_hash  => $::apache::options,
    settings_hash => $::apache::real_settings,
    data_module   => $::apache::data_module,
    conf_hash     => $confs,
    dir_hash      => $dirs,
    auto_conf     => $::apache::auto_conf,
    auto_repo     => $::apache::auto_depend,
  }

}
