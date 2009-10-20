require File.dirname(__FILE__) + '/spec_helper'

describe "getting assignments" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_assignments')
  end

  it "should ensure required params" do
    lambda{RTurk::GetAssignments(:page_number => 5)}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request an assignment" do
    RTurk::Requester.should_receive(:request).with(anything(), anything(), anything(), hash_including('Operation' => 'GetAssignmentsForHIT'))
    response = RTurk::GetAssignments(:hit_id => "abcd")
  end
  
  it "should parse and return and answer" do
    response = RTurk::GetAssignments(:hit_id => "abcd")
    response.answer['Question100'].should eql("Move to X.")
  end

end
