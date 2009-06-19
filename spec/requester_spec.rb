require File.dirname(__FILE__) + '/spec_helper'

describe RTurk::Requester do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    @turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should perform raw operations" do
    @turk.request(:Operation => 'GetHIT', 'HITId' => 'test').include?(:errors).should be_true
    # p turk.getHIT(:HITId => 'test')
  end
  
  it "should also interpret methods as operations" do
    @turk.getHIT(:HITId => 'test')
  end
  
end