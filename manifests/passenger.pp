# Class apache::passenger
#
# Apache resources specific for passenger
#
class apache::passenger {

  require apache

  case $::operatingsystem {
    ubuntu,debian,mint: { 
      package { 'libapache2-mod-passenger':
        ensure => present;
      }     
    }

    centos,redhat,scientific,fedora: {
      package { 'mod_passenger':
        ensure => present;
      }
    }
  }

}
