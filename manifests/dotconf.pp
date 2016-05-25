define apache::dotconf (
  Variant[Boolean,String] $ensure   = '',

  Variant[Undef,String]   $source   = undef,
  Variant[Undef,String]   $template = undef,
  Variant[Undef,String]   $epp      = undef,
  Variant[Undef,String]   $content  = undef,

  Hash                    $options  = { },

) {

  include ::apache

  tp::conf { "apache::${title}":
    ensure             => pick($ensure, $::apache::ensure),
    base_dir           => 'conf',
    template           => $template,
    epp                => $epp,
    content            => $content,
    source             => $source,
    options_hash       => $::apache::options + $options,
    data_module        => $::apache::data_module,
    settings           => $::apache::real_settings,
    config_file_notify => $::apache::service_notify,
  }

}
