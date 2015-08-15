require 'open-uri'

module Puppet::Parser::Functions
  newfunction(:get_mumble_source_url, :type => :rvalue) do |args|
    suffix = args[0]
    if args.length > 1 then
      version = args[1]
    else
      version = 'latest'
    end
    begin
      html = open("https://github.com/mumble-voip/mumble/releases/#{version}").read
      rescue SocketError
      html = ''
    end
    res = /(?<version>[\/\w\.-]+)\.msi/.match(html)
    if res == nil then
      return ''
    end
    version = res[:version]
    version = 'https://github.com' + version + '.' + suffix
    begin
      sig = open("#{version}.sig").read
      rescue SocketError
      sig = ''
    end
    if /BEGIN PGP SIGNATURE/.match(sig) then
      return version
    else
      return ''
    end
  end
end
