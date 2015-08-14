require 'open-uri'

module Puppet::Parser::Functions
  newfunction(:get_latest_mumble_release_url_base, :type => :rvalue) do |args|
    suffix = args[0]
    begin
      html = open('https://github.com/mumble-voip/mumble/releases/latest').read
      rescue SocketError
      html = ''
    end
    res = /(?<latest>[\/\w\.-]+)\.msi/.match(html)
    if res == nil then
      return ''
    end
    latest = res[:latest]
    latest = 'https://github.com' + latest + '.' + suffix
    begin
      sig = open("#{latest}.sig").read
      rescue SocketError
      sig = ''
    end
    if /BEGIN PGP SIGNATURE/.match(sig) then
      return latest
    else
      return ''
    end
  end
end
