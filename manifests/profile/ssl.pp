class apache::profile::ssl (
  Variant[Boolean,String]  $ensure           = present,
  Hash                     $options          = { },
  Variant[Undef,String[1]] $template         = undef,
) {

  include apache

  apache::module { 'ssl':
    template        => $template,
    options         => $::apache::options + $options,
    package_install => true,
  }

}
