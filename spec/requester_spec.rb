require File.dirname(__FILE__) + '/spec_helper'

describe RTurk::Requester do

  before(:all) do
    FakeWeb.clean_registry
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should send the request to Amazon" do
    RestClient.should_receive(:get).with(/amazonaws.*Operation=GetHIT.*$/)
    RTurk::Requester.request(:Operation => 'GetHIT', 'HITId' => 'test')
  end


  
end