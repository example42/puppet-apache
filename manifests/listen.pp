# = Define: apache::listen
#
# This define creates a Listen statement in Apache configuration
# It adds a single configuration file to Apache conf.d with the Listen
# statement
#
# == Parameters
#
# [*namevirtualhost*]
#   If to add a NameVirtualHost for this port. Default: *
#   (it creates a NameVirtualHost <%= @namevirtualhost %>:<%= @port %> entry)
#   Set to false to listen to the port without a NameVirtualHost
#
# [*enable*]
#   Set to false to disable the listen configuration.
#   Work only on Debian 8 and Ubuntu 14
#
# == Examples
#
# apache::listen { '8080':}
#
define apache::listen (
  $enable          = true,
  $namevirtualhost = '*',
  $ensure          = 'present',
  $template        = 'apache/listen.conf.erb',
  $notify_service  = true
) {

  include apache

  apache::dotconf { "0000_listen_${name}":
    ensure  => $ensure,
    enable  => $enable,
    content => template($template),
  }

}
