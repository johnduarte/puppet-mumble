module Puppet::Parser::Functions
  newfunction(:get_latest, :type => :rvalue) do |args|
    cmd = 'curl -L https://github.com/mumble-voip/mumble/releases/latest | sed -n "s/.*href=\"\(.*\)\.msi\".*/\1/p"'
    latest = exec cmd
    unless latest.empty? then
      return 'https://github.com' + latest
    else
      return ''
    end
  end
end
