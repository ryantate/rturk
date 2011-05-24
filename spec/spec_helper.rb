SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? SPEC_ROOT
$: << SPEC_ROOT
$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'spec'
require 'fakeweb'
require 'yaml'
require 'webmock'
include WebMock::API

require 'rturk'
# RTurk.log.level = Logger::DEBUG

@aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)

def faker(response_name, opts = {})
  response = File.read(File.join(SPEC_ROOT, 'fake_responses', "#{response_name.to_s}.xml"))
  if opts[:operation]
    stub_request(:post, /amazonaws.com/).with(:body => /Operation=#{opts[:operation]}/).to_return(:body => response)
  else
    stub_request(:post, /amazonaws.com/).to_return(:body => response)
  end
end

def fake_response(xml)
  mock('RestClientFakeResponse', :body => xml)
end

Spec::Runner.configure do |config|

end
