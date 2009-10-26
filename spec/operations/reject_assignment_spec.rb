require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::RejectAssignment do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('reject_assignment', :operation => 'RejectAssignment')
  end

  it "should ensure required params" do
    lambda{RTurk::RejectAssignment(:assignment_id => "123456789")}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'RejectAssignment'))
    RTurk::RejectAssignment(:assignment_id => "123456789", :feedback => "This work of your, it is terrible!") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::RejectAssignment(:assignment_id => "123456789", :feedback => "This work of your, it is terrible!").should
      be_a_kind_of RTurk::Response
  end

end