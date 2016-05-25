define apache::vhost (
  Variant[Boolean,String] $ensure           = '',
  String[1]               $template         = 'apache/vhost/vhost.conf.erb',
  Hash                    $options          = { },

) {

  include ::apache

  tp::conf { "apache::${title}":
    ensure             => pick($ensure, $::apache::ensure),
    base_dir           => 'vhost',
    template           => $template,
    options_hash       => $::apache::options + $options,
    data_module        => $::apache::data_module,
    settings           => $::apache::module_settings,
    config_file_notify => $::apache::service_notify,
  }

}
