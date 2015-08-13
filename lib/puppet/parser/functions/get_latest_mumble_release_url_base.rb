require 'open-uri'

module Puppet::Parser::Functions
  newfunction(:get_latest_mumble_release_url_base, :type => :rvalue) do |args|
    suffix = args[0]
    html = open('https://github.com/mumble-voip/mumble/releases/latest').read
    res = /(?<latest>[\/\w\.-]+)\.msi/.match(html)
    latest = res[:latest]
    latest = 'https://github.com' + latest + '.' + suffix
    sig = open("#{latest}.sig").read
    if /BEGIN PGP SIGNATURE/.match(sig) then
      latest
    else
      ''
    end
  end
end
