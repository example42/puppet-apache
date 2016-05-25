class apache::profile::loadbalancer (
  Hash                    $options          = { },
  String[1]               $template         = 'apache/profile/loadbalancer/loadbalancer.conf.erb',
) {

  include apache

  tp::conf { 'apache::loadbalancer.conf':
    base_dir      => 'conf',
    template      => $template,
    options_hash  => $::apache::options + $options,
    data_module   => $::apache::data_module,
    settings_hash => $::apache::real_settings,
  }

}
