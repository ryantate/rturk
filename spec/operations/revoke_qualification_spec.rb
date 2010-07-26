require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::RevokeQualification do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('revoke_qualification', :operation => 'RevokeQualification')
  end

  it "should ensure required params" do
    lambda{RTurk::RevokeQualification()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'RevokeQualification'))
    RTurk::RevokeQualification(:qualification_type_id => "123456789",
                               :subject_id => "ABCDEF1234") rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    RTurk::RevokeQualification(:qualification_type_id => "123456789",
                               :subject_id => "ABCDEF1234").elements.should eql(
      {"RevokeQualificationResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end
end