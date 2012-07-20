require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::ApproveRejectedAssignment do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('approve_rejected_assignment', :operation => 'ApproveRejectedAssignment')
  end

  it "should ensure required params" do
    lambda{RTurk::ApproveRejectedAssignment()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'ApproveRejectedAssignment'))
    RTurk::ApproveRejectedAssignment(:assignment_id => "123456789") rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    RTurk::ApproveRejectedAssignment(:assignment_id => "123456789").elements.should eql(
      {"ApproveRejectedAssignmentResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end

end

