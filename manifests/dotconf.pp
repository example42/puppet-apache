define apache::dotconf (
  Variant[Boolean,String] $ensure           = present,

  Variant[Undef,String]   $source              = undef,
  Variant[Undef,String]   $template            = undef,
  Variant[Undef,String]   $epp                 = undef,
  Variant[Undef,String]   $content             = undef,

  Hash                    $options          = { },
  Hash                    $settings         = { },
) {

  tp::conf { "apache::${title}":
    base_dir     => 'conf',
    template     => $template,
    epp          => $epp,
    content      => $content,
    source       => $source,
    options_hash => $options + $::apache::options,
    data_module  => pick_default($::apache::data_module, 'apache'),
  }

}
