require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::CreateQualificationType do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_qualification_type', :operation => 'CreateQualificationType')
  end

  it "should ensure required params" do
    lambda{RTurk::CreateQualificationType()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'CreateQualificationType'))
    RTurk::CreateQualificationType(:name => "bogus", :description => 'really bogus') rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::CreateQualificationType(:name => "bogus", :description => 'really bogus')
    response.qualification_type_id.should == "ZSPJXD4F1SFZP7YNJWR0"
  end
end