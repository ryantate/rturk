require 'rubygems'
require 'spec'
require 'fakeweb'
module FakeWeb
  class Registry
    # Comment out this override if you're using a quantum computer 
    def variations_of_uri_as_strings(uri)
      [uri.to_s]
    end
    
  end
end

SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(SPEC_ROOT)
$LOAD_PATH.unshift(File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib'))

require 'rturk'
RTurk.logger.level = Logger::DEBUG

@aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))

def faker(response_name)
  response = File.read(File.join(SPEC_ROOT, 'fake_responses', "#{response_name.to_s}.xml"))
  FakeWeb.register_uri(:get, /amazonaws\.com/, :body => response)
end

Spec::Runner.configure do |config|
  
end