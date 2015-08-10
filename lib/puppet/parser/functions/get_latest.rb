module Puppet::Parser::Functions
  newfunction(:get_latest, :type => :rvalue) do |args|
    require 'open3'
    cmd = 'curl -L https://github.com/mumble-voip/mumble/releases/latest | sed -n "s/.*href=\"\(.*\)\.msi\".*/\1/p"'
    latest = Open3.capture2(cmd)[0].chomp
    unless latest.empty? then
      return 'https://github.com' + latest
    else
      return ''
    end
  end
end
