define apache::vhost (
  Variant[Boolean,String] $ensure           = present,

  String[1]               $template         = 'apache/vhost/vhost.conf.erb',
  Hash                    $options          = { },

  Hash                    $settings         = { },
  String[1]               $data_module      = 'apache',
) {

  tp::conf { "apache::${title}":
    base_dir     => 'vhost',
    template     => $template,
    options_hash => $options + $::apache::options,
    data_module  => pick_default($::apache::data_module, $data_module),
  }

}
