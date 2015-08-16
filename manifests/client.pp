#
class mumble::client (
  $package_ensure  = $mumble::params::client_package_ensure,
  $package_name    = $mumble::params::client_package_name,
  $package_source  = undef,
  $version         = 'latest',
) inherits mumble::params {
validate_string($package_ensure)
validate_string($package_name)
validate_string($package_source)
validate_string($version)

  if $package_source == undef {
    if $::osfamily == 'windows' {
      $_package_source  = get_mumble_source_url('msi', $version)
    } else {
      $_package_source  = $package_source
    }
  }
  package { 'mumble-client':
    ensure          => $package_ensure,
    name            => $package_name,
    source          => $_package_source,
  }

}
