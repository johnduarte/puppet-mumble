require 'spec_helper'

describe "mumble::server" do
  let(:facts) { {:operatingsystem => 'Debian'} }
  it { should create_service('mumble-server')}
end
