#
class mumble::client (
  $package_ensure  = $mumble::params::client_package_ensure,
  $package_manage  = $mumble::params::client_package_manage,
  $package_name    = $mumble::params::client_package_name,
) inherits mumble::params {

  case $::operatingsystem {
    'Windows': {
      $package_source = 'https://github.com/mumble-voip/mumble/releases/download/1.2.10/mumble-1.2.10.msi'
    }
    default: {
    }
  }

  contain '::mumble::client::install'
}
