class apache::profile::passenger (
  Variant[Boolean,String]  $ensure    = '',
  Hash                     $options   = { },
  Variant[Undef,String[1]] $template  = undef,
) {

  include ::apache

  ::apache::module { 'passenger':
    ensure          => pick($ensure, $::apache::ensure),
    template        => $template,
    options         => $::apache::options + $options,
    package_install => true,
  }

}
