#
class mumble::client (
  $package_ensure  = $mumble::params::client_package_ensure,
  $package_name    = $mumble::params::client_package_name,
  $package_source  = $mumble::params::client_package_source,
) inherits mumble::params {

  contain '::mumble::client::install'
}
