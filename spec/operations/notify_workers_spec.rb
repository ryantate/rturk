require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::NotifyWorkers do
  before(:each) do
    @lambda = lambda do
      begin
        RTurk::NotifyWorkers(:worker_ids => [*1..100],
                             :subject => 'Return of the Mack',
                             :message_text => 'Mark Morrison, kicking up the jams in 1996')
      rescue RTurk::InvalidRequest
      end
    end
  end

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('notify_workers', :operation => 'NotifyWorkers')
  end

  it 'should ensure required params' do
    lambda {
      RTurk::NotifyWorkers(:subject => 'peruvian mcwallball')
    }.should raise_error RTurk::MissingParameters
  end

  it 'should successfully request the operation' do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'NotifyWorkers')).and_return(
      fake_response(''))

    @lambda.call
  end

  it 'should parse and return the result' do
    @lambda.call.should be_a_kind_of RTurk::Response
  end

  it 'should not allow more than 100 worker ids' do
    lambda {
      RTurk.NotifyWorkers(:worker_ids => [*1..1000],
                          :subject => 'BOOM',
                          :message_text => 'SHAKA LAKA')
    }.should raise_error(ArgumentError, 'Cannot send a message to more than 100 workers at a time.')
  end

  it 'should not allow for a message longer than 4096 characters' do
    lambda {
      RTurk.NotifyWorkers(:worker_ids => [*1..100],
                          :subject => 'BOOM',
                          :message_text => '!' * 4097)
    }.should raise_error(ArgumentError, 'Message cannot be longer than 4096 characters.')
  end

  it 'should not allow for a subject longer than 200 characters' do
    lambda {
      RTurk.NotifyWorkers(:worker_ids => [*1..100],
                          :subject => '!' * 201,
                          :message_text => 'WINK')
    }.should raise_error(ArgumentError, 'Subject cannot be longer than 200 characters.')
  end
end
