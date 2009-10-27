require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::UnblockWorker do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('unblock_worker', :operation => 'UnblockWorker')
  end

  it "should ensure required params" do
    lambda{RTurk::UnblockWorker(:reason => 'foo')}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'UnblockWorker'))
    RTurk::UnblockWorker(:worker_id => "123456789", :reason => "Really poor work") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::UnblockWorker(:worker_id => "123456789", :reason => "Really poor work").should
      be_a_kind_of RTurk::Response
  end

end