# See README.md.
class mumble::client::install {

  package { 'mumble-client':
    ensure          => $mumble::client::package_ensure,
    install_options => $mumble::client::install_options,
    name            => $mumble::client::package_name,
    source          => $mumble::client::package_source,
  }

}
