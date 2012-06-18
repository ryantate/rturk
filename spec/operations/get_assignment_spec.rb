require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetAssignment do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  it "should ensure required params" do
    lambda{RTurk::GetAssignment()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request an assignment" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GetAssignment'))
    RTurk::GetAssignment(:assignment_id => "abcd") rescue RTurk::InvalidRequest
  end

  context "an HIT with one assignment" do
    before(:all) do
      WebMock.reset!
      faker('get_assignment', :operation => 'GetAssignment')
    end

    it "should parse and return and answer" do
      answers = RTurk::GetAssignment(:assignment_id => "abcd").assignment.answers
      answers['Question100'].should eql("Move to X.")
    end

    it "should parse and return the hit" do
      hit = RTurk::GetAssignment(:assignment_id => "abcd").hit
      hit.title.should eql("Location")
    end
  end
end
