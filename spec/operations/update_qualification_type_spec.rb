require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::UpdateQualificationType do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('update_qualification_type', :operation => 'UpdateQualificationType')
  end

  it "should ensure required params" do
    lambda{RTurk::UpdateQualificationType()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'UpdateQualificationType'))
    RTurk::UpdateQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE', :name => "bogus") rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::UpdateQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE', :name => "bogus")
    response.qualification_type_id.should == "789RVWYBAZW00EXAMPLE"
  end
end