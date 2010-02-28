require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::SendTestEventNotification do
  before(:each) do
    @lambda = lambda do
      n = RTurk::Notification.new
      n.transport = 'foo'
      n.destination = 'bar'
      n.event_type = 'baz'

      begin
        RTurk::SendTestEventNotification(:test_event_type => 'foo',
                                         :notification => n)
      rescue RTurk::InvalidRequest
      end
    end
  end

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('notify_workers', :operation => 'SendTestEventNotification')
  end

  it 'should ensure required params' do
    lambda {
      RTurk::SetHITTypeNotification(:subject => 'peruvian mcwallball')
    }.should raise_error RTurk::MissingParameters
  end

  it 'should successfully request the operation' do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'SendTestEventNotification')).and_return(
      fake_response(''))

    @lambda.call
  end

  it 'should parse and return the result' do
    @lambda.call.should be_a_kind_of RTurk::Response
  end
end

