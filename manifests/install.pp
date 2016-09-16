# == Class keepalived::install
#
class keepalived::install {
  package { $::keepalived::pkg_list:
    ensure => $::keepalived::pkg_ensure,
  }

  # Update systemd unit file on debian jessie
  if ( $::lsbmajdistrelease > 8 ) {
    fail('We probably should use packages systemd unit file. Failing because of it')
  } elsif ( $::lsbmajdistrelease == 8 ) {
    file { '/etc/systemd/system/keepalived.service':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/keepalived/keepalived.systemd',
        notify  => [ Service['keepalived'], Package['keepalived'], ],
    }
  }

}

