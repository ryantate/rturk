require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GrantQualification do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('grant_qualification', :operation => 'GrantQualification')
  end

  it "should ensure required params" do
    lambda{RTurk::GrantQualification()}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GrantQualification'))
    RTurk::GrantQualification(:qualification_request_id => "789RVWYBAZW00EXAMPLE951RVWYBAZW00EXAMPLE") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::GrantQualification(:qualification_request_id => "789RVWYBAZW00EXAMPLE951RVWYBAZW00EXAMPLE").elements.should eql(
      {"GrantQualificationResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end

end