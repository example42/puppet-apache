class apache::install::package (
  String $ensure           = '',
) {

  include ::apache

  package { $::apache::real_settings['package_name']:
    ensure => pick($ensure, $::apache::ensure),
  }

}
