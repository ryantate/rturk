require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetBlockedWorkers do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_blocked_workers', :operation => 'GetBlockedWorkers')
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
    hash_including('Operation' => 'GetBlockedWorkers'))
    RTurk::GetBlockedWorkers() rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::GetBlockedWorkers()
    response.num_results.should == 2
    response.workers.length.should == 2
    response.workers[0].worker_id.should == 'A2QWESAMPLE1'
    response.workers[0].reason.should == 'Poor Quality Work on Categorization'
  end
end
