require_relative '../spec_helper'

describe 'ops::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
=begin
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set["env"] = "ruby"
    end.converge(described_recipe)
  end
=end
  it 'Install Nginx' do
    expect(:chef_run).to install_package('nginx')
  end

  it 'Create nginx.conf' do
    expect(:chef_run).to create_template("/etc/nginx/nginx.conf")
  end
end
