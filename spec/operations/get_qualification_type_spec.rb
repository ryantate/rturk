require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetQualificationType do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_qualification_type', :operation => 'GetQualificationType')
  end

  it "should ensure required params" do
    lambda{RTurk::GetQualificationType()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GetQualificationType'))
    RTurk::GetQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE') rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::GetQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE')
    response.name.should == 'EnglishWritingAbility'
    response.description.should == "The ability to write and edit text..."
    response.keywords.should == ["English", "text", "write", "edit", "language"]
  end
end