require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Response do
  
  context "given an invalid response" do
  
    before(:all) do
      @response = RTurk::Response.new(File.open(File.join(SPEC_ROOT,'fake_responses','invalid_credentials.xml')))
    end
    
    it "should know it failed" do
      @response.success?.should be_false
    end
    
    it "should know why" do
      @response.errors.first[:code].should eql("AWS.NotAuthorized")
      @response.errors.first[:message].should eql("The identity contained in the request is not authorized to use this AWSAccessKeyId")
    end
    
  end
  
  context "given a valid response" do
  
    before(:all) do
      @response = RTurk::Response.new(File.open(File.join(SPEC_ROOT,'fake_responses','create_hit.xml')))
    end
    
    it "should know it succeded" do
      @response.success?.should be_true
    end
    
    it "should not have errors attached" do
      @response.errors.should be_empty
    end
    
  end
  
end