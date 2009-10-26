require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "getting assignments" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_assignments', :operation => 'GetAssignmentsForHIT')
  end

  it "should ensure required params" do
    lambda{RTurk::GetAssignmentsForHIT(:page_number => 5)}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request an assignment" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GetAssignmentsForHIT'))
    RTurk::GetAssignmentsForHIT(:hit_id => "abcd") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return and answer" do
    assignments = RTurk::GetAssignmentsForHIT(:hit_id => "abcd").assignments
    assignments.first.answers['tweet'].should eql("This is my tweet!")
  end

end
