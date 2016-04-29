define apache::vhost (
  Variant[Boolean,String] $ensure           = present,

  String[1]               $template         = 'apache/vhost/vhost.conf.erb',
  Hash                    $options          = { },

) {

  include ::apache

  tp::conf { "apache::${title}":
    base_dir           => 'vhost',
    template           => $template,
    options_hash       => $::apache::options + $options,
    data_module        => $::apache::data_module,
    settings           => $::apache::module_settings,
    config_file_notify => $::apache::service_autorestart,
  }

}
