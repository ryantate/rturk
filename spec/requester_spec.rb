require File.dirname(__FILE__) + '/spec_helper'

describe RTurk::Requester do

  before(:all) do
    FakeWeb.clean_registry
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should perform raw operations" do
    response = RTurk::Response.new(response = RTurk::Requester.request(:Operation => 'GetHIT', 'HITId' => 'test'))
    response['GetHITResponse']['HIT']['Request'].include?('Errors').should be_true
  end
  
  it "should be able to tell when it's in sandbox" do 
    RTurk.sandbox?
  end
  
  it "should return its environment as production, the default" do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'])
    RTurk.sandbox?.should be_false
  end
  
end