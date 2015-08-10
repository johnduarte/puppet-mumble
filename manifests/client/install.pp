# See README.md.
class mumble::client::install {

  if $mumble::client::package_manage {

    package { 'mumble_client':
      ensure          => $mumble::client::package_ensure,
      install_options => $mumble::client::install_options,
      name            => $mumble::client::package_name,
    }

  }

}
