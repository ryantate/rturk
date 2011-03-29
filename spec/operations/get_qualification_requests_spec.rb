require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetQualificationRequests do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_qualification_requests', :operation => 'GetQualificationRequests')
  end

  it "should ensure required params" do
    lambda{RTurk::GetQualificationRequests()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
    hash_including('Operation' => 'GetQualificationRequests'))
    RTurk::GetQualificationRequests(:qualification_type_id => '789RVWYBAZW00EXAMPLE') rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::GetQualificationRequests(:qualification_type_id => '789RVWYBAZW00EXAMPLE')
    response.num_results.should == 1
    response.qualification_requests.length.should == 1
    response.qualification_requests[0].qualification_request_id.should == '789RVWYBAZW00EXAMPLE951RVWYBAZW00EXAMPLE'
    response.qualification_requests[0].subject_id.should == 'AZ3456EXAMPLE'
  end
end