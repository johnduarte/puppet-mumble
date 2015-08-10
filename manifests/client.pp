#
class mumble::client (
  $package_ensure  = $mumble::params::client_package_ensure,
  $package_manage  = $mumble::params::client_package_manage,
  $package_name    = $mumble::params::client_package_name,
) inherits mumble::params {

  case $::operatingsystem {
    'Windows': {
      $latest_url = get_latest_mumble_release_url_base()
      $package_source = "${latest_url}.msi"
    }
    default: {
    }
  }

  contain '::mumble::client::install'
}
