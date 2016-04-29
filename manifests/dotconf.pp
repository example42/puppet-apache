define apache::dotconf (
  Variant[Boolean,String] $ensure           = present,

  Variant[Undef,String]   $source              = undef,
  Variant[Undef,String]   $template            = undef,
  Variant[Undef,String]   $epp                 = undef,
  Variant[Undef,String]   $content             = undef,

  Hash                    $options          = { },

) {

  include ::apache

  tp::conf { "apache::${title}":
    base_dir     => 'conf',
    template     => $template,
    epp          => $epp,
    content      => $content,
    source       => $source,
    options_hash => $::apache::options + $options,
    data_module  => $::apache::data_module,
    settings     => $::apache::module_settings,
  }

}
