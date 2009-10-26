require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::ApproveAssignment do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('approve_assignment', :operation => 'ApproveAssignment')
  end

  it "should ensure required params" do
    lambda{RTurk::ApproveAssignment()}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'ApproveAssignment'))
    RTurk::ApproveAssignment(:assignment_id => "123456789") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::ApproveAssignment(:assignment_id => "123456789").elements.should eql(
      {"ApproveAssignmentResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end

end