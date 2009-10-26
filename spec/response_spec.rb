require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Response do
  
  context "given an invalid response" do
  
    before(:all) do
      @invalid_credentials_xml = File.read(File.join(SPEC_ROOT,'fake_responses','invalid_credentials.xml'))
      
    end
    
    it "should know it failed" do
      lambda{RTurk::Response.new(@invalid_credentials_xml)}.should raise_error RTurk::InvalidRequest
    end
    
    it "should know why" do
      begin
        RTurk::Response.new(@invalid_credentials_xml)
      rescue RTurk::InvalidRequest => e
        e.message.should eql("AWS.NotAuthorized: The identity contained in the request is not authorized to use this AWSAccessKeyId")
      end

    end
    
  end
  
  context "given a valid response" do
  
    before(:all) do
      @response = RTurk::Response.new(File.read(File.join(SPEC_ROOT,'fake_responses','create_hit.xml')))
    end
    
    it "should know it succeded" do
      @response.success?.should be_true
    end
    
    it "should not have errors attached" do
      @response.errors.should be_empty
    end
    
    it "should give back the xml as a hash" do
      @response.elements['CreateHITResponse']['HIT']['HITId'].should == 'GBHZVQX3EHXZ2AYDY2T0'
    end
    
  end
  
end