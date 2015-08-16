# Private class: See README.md.
class mumble::params {

  # server params
  $autostart          = true      # Start server at boot
  $ppa                = false     # Use PPA
  $snapshot           = false     # PPA only: use snapshot over release
  $libicu_fix         = false     # install libicu-dev to fix dependency
  $server_password    = undef     # Supervisor account password
  $version            = installed # Version of mumble to install

  # The following parameters affect mumble-server.ini through a template
  # For more info, see http://mumble.sourceforge.net/Murmur.ini
  $config_file        = '/etc/mumble-server.ini'
  $manage_config_file = false
  $register_name      = 'Mumble Server'
  $password           = ''    # General entrance password
  $port               = 64738
  $host               = ''
  $user               = 'mumble-server'
  $group              = 'mumble-server'
  $bandwidth          = 72000
  $users              = 100
  $text_length_limit  = 5000
  $autoban_attempts   = 10
  $autoban_time_frame = 120
  $autoban_time       = 300
  $database_path      = '/var/lib/mumble-server/mumble-server.sqlite'
  $log_path           = '/var/log/mumble-server/mumble-server.log'
  $allow_html         = true
  $log_days           = 31
  $ssl_cert           = ''
  $ssl_key            = ''
  $welcome_text       = '<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />'

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $server_package_name    = 'mumble-server'
          $client_package_name    = 'mumble'
          if $ppa {
            if $::os.release.full == '12.04' {
              $libicu_fix = true
            }
          }
        }
        default: {
          $server_package_name    = 'mumble-server'
          $client_package_name    = 'mumble'
        }
      }
    }
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          if (versioncmp($::operatingsystemrelease, '13') >= 0) {
            if (versioncmp($::operatingsystemrelease, '20') <= 0) {
              $server_package_name    = 'mumble-server'
              $client_package_name    = 'mumble'
            } else {
              fail("Only fedora versions 13-20 are supported")
            }
          } else {
            fail("Only fedora versions 13-20 are supported")
          }
        }
        'ArchLinux': {
          $server_package_name    = 'murmur'
          $client_package_name    = 'mumble'
        }
        default: {
          fail("${::operatingsystem} is not supported")
        }
      }
    }
    'windows': {
      $client_package_name    = 'Mumble 1.2.10'
      #$install_options        = ['INSTALLDIR=C:\\java', 'STATIC=1', '/s']
    }
    'darwin': {
      fail("MacOS is not supported")
    }
    default: {
      $server_package_name    = 'mumble-server'
      $client_package_name    = 'mumble'
    }
  }
}
