SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? SPEC_ROOT
$: << SPEC_ROOT
$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'spec'
require 'fakeweb'
require 'yaml'
module FakeWeb
  class Registry
    # Comment out this override if you're using a quantum computer 
    def variations_of_uri_as_strings(uri)
      [uri.to_s]
    end
    
  end
end

require 'rturk'
# RTurk.log.level = Logger::DEBUG

@aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)

def faker(response_name, opts = {})
  if opts[:operation]
    match = %r[amazonaws\.com\/?\?.*Operation=#{opts[:operation]}.*$]
  else
    match = %r[amazonaws\.com]
  end
  response = File.read(File.join(SPEC_ROOT, 'fake_responses', "#{response_name.to_s}.xml"))
  FakeWeb.register_uri(:get, match, :body => response)
end

def fake_response(xml)
  mock('RestClientFakeResponse', :body => xml)
end

Spec::Runner.configure do |config|
  
end