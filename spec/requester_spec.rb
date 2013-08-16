require 'spec_helper'

describe RTurk::Requester do

  before(:all) do
    WebMock.reset!
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should send the request to Amazon" do
    RestClient.should_receive(:post).with(/amazonaws/, /Operation=GetHIT.*$/)
    RTurk::Requester.request(:Operation => 'GetHIT', 'HITId' => 'test')
  end

  it "should use UTC and ISO8601 format for the timestamp" do
    now = Time.now
    utc = now.utc
    Time.should_receive(:now).and_return(now)  # freeze time for a moment
    RestClient.should_receive(:post).with(/amazonaws/, /Timestamp=#{CGI.escape(utc.iso8601)}/)
    RTurk::Requester.request(:Operation => 'GetHIT', 'HITId' => 'test')
  end

  it "should build a correct querystring with one value per key" do
    params = {
      :Operation => 'GetHIT',
      'Param1' => 'test1',
      'Param2' => 'test2'
    }
    RestClient.should_receive(:post).with(
      /amazonaws/,
      /(?=.*Operation=GetHIT)(?=.*Param1=test1)(?=.*Param2=test2)/)
    RTurk::Requester.request(params)
  end

  it "should build a correct querystring with two values per key" do
    params = {
      :Operation => 'GetHIT',
      'Param1' => 'test1',
      'Param2' => %w(test2a test2b)
    }
    RestClient.should_receive(:post).with(
      /amazonaws/,
      /(?=.*Operation=GetHIT)(?=.*Param1=test1)(?=.*Param2=test2a)(?=.*Param2=test2b)/)
    RTurk::Requester.request(params)
  end

  it "should build a correct querystring with a hash of values" do
    params = {
      :Operation => 'GetHIT',
      'Param1' => 'test1',
      'Param2' => {0 => 'test2a', 1 => 'test2b'}
    }
    RestClient.should_receive(:post).with(
      /amazonaws/,
      /(?=.*Operation=GetHIT)(?=.*Param1=test1)(?=.*Param2.0=test2a)(?=.*Param2.1=test2b)/)
    RTurk::Requester.request(params)
  end
  
  it "should raise RTurk::ServiceUnavaile on HTTP 503 Errors" do
    error_503 = RestClient::Exception.new(nil, 503)
    params = {
      :Operation => 'GetHIT',
      'Param1' => 'test1',
      'Param2' => {0 => 'test2a', 1 => 'test2b'}
    }
    RestClient.stub(:post).and_raise(error_503)
    lambda {
      RTurk::Requester.request(params)
    }.should raise_error RTurk::ServiceUnavailable
  end
  
  it "should be able to leverage retry_on_unavailable to simplify AWS ServiceUnavailable Errors " do
    error_503 = RestClient::Exception.new(nil, 503) #ServiceUnavailable
    error_408 = RestClient::Exception.new(nil, 408) #Timeout
    params = {
      :Operation => 'GetHIT',
      'Param1' => 'test1',
      'Param2' => {0 => 'test2a', 1 => 'test2b'}
    }
    attempts = 0
    lambda { 
      # Wrap in retry block with delay of 0 seconds
      RTurk::Utilities.retry_on_unavailable(0) do
        # Ensure the first request triggers a retry with 503, subsequently raise 408 Timeout
        if attempts == 0
          RestClient.stub(:post).and_raise(error_503)
        else
          RestClient.stub(:post).and_raise(error_408)
        end
        attempts = attempts + 1
        RTurk::Requester.request(params)
      end
    }.should raise_error RestClient::Exception
    attempts.should eql(2)
  end
end
