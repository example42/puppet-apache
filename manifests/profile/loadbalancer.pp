class apache::profile::loadbalancer (
  Hash                    $options          = { },
  String[1]               $template         = 'apache/profile/loadbalancer/loadbalancer.conf.erb',
) {

  tp::conf { 'apache::loadbalancer.conf':
    base_dir     => 'conf',
    template     => $template,
    options_hash => $options + $::apache::options,
    data_module  => pick_default($::apache::data_module, 'apache'),
  }

}
