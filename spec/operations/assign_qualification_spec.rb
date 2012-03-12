require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::AssignQualification do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('assign_qualification', :operation => 'AssignQualification')
  end

  it "should ensure required params" do
    lambda{RTurk::AssignQualification()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'AssignQualification', 'IntegerValue' => 80))
    RTurk::AssignQualification(:qualification_type_id => "123456789",
                               :worker_id => "ABCDEF1234",
                               :integer_value => 80) rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    RTurk::AssignQualification(:qualification_type_id => "123456789",
                               :worker_id => "ABCDEF1234",
                               :integer_value => 80).elements.should eql(
      {"AssignQualificationResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end
end