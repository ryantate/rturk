require File.dirname(__FILE__) + '/spec_helper'

describe RTurk::Requester do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    @turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should perform raw operations" do
    response = @turk.request(:Operation => 'GetHIT', 'HITId' => 'test')
    response['HIT']['Request'].include?('Errors').should be_true
  end
  
  it "should also interpret methods as operations" do
    @turk.getHIT(:HITId => 'test')
  end
  
  it "should return its environment" do 
    @turk.environment.should == 'sandbox'
  end
  
  it "should return its environment as production, the default" do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    @turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'])
    @turk.environment.should == 'production'
  end
  
end