# Class: mumble::server:  See README.md for documentation.
class mumble::server (
  $config_file        = $mumble::params::config_file,
  $manage_config_file = $mumble::params::manage_config_file,
  $autostart          = $mumble::params::autostart,
  $ppa                = $mumble::params::ppa,
  $snapshot           = $mumble::params::snapshot,
  $libicu_fix         = $mumble::params::libicu_fix,
  $server_password    = $mumble::params::server_password,
  $version            = $mumble::params::version,
  $register_name      = $mumble::params::register_name,
  $password           = $mumble::params::password,
  $port               = $mumble::params::port,
  $host               = $mumble::params::host,
  $user               = $mumble::params::user,
  $group              = $mumble::params::group,
  $bandwidth          = $mumble::params::bandwidth,
  $users              = $mumble::params::users,
  $text_length_limit  = $mumble::params::text_length_limit,
  $autoban_attempts   = $mumble::params::autoban_attempts,
  $autoban_time_frame = $mumble::params::autoban_time_frame,
  $autoban_time       = $mumble::params::autoban_time,
  $database_path      = $mumble::params::database_path,
  $log_path           = $mumble::params::log_path,
  $allow_html         = $mumble::params::allow_html,
  $log_days           = $mumble::params::log_days,
  $ssl_cert           = $mumble::params::ssl_cert,
  $ssl_key            = $mumble::params::ssl_key,
  ) inherits mumble::params {

  case $::operatingsystem {
    'Ubuntu': {
      if $ppa {
        apt::ppa { 'ppa:mumble/snapshot':
          # ensure => $snapshot ? { true => 'present', false => 'absent' },
          before => Package['mumble-server'],
        }
        apt::ppa { 'ppa:mumble/release':
          # ensure => $snapshot ? { false => 'present', true => 'absent' },
          before => Package['mumble-server']
        }
      }
      else {
        # apt::ppa { ['ppa:mumble/snapshot', 'ppa:mumble/release']:
        #   ensure => 'absent'
        # }
      }
      # Missing dependency for 12.04 with PPA
      if $libicu_fix {
        package { 'libicu-dev':
          before => Package['mumble-server']
        }
      }
    }
    'Debian': {
    }
    default: {
      fail("${::operatingsystem} is not yet supported.")
    }
  }

  package { 'mumble-server':
    ensure => $version,
  }

  group { $group:
    require => Package['mumble-server'],
  }

  user { $user:
    gid     => $group,
    require => [Group[$group], Package['mumble-server']],
  }

  if $mumble::server::manage_config_file  {
    file { 'mumble-config-file':
      path    => $mumble::server::config_file,
      owner   => $user,
      group   => $group,
      replace => true,
      content => template('mumble/mumble-server.erb'),
      require => Package['mumble-server'],
      notify  => Service['mumble-server'],
    }
  }

  service { 'mumble-server':
    ensure    => running,
    enable    => $autostart,
  }

  if $server_password != undef {
    exec { 'mumble_set_password':
      command => "murmurd -supw ${server_password}",
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
      require => Service['mumble-server'],
    }
  }
}
