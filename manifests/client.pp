#
class mumble::client (
  $package_ensure  = $mumble::params::client_package_ensure,
  $package_manage  = $mumble::params::client_package_manage,
  $package_name    = $mumble::params::client_package_name,
) inherits mumble::params {
  contain '::mumble::client::install'
}
