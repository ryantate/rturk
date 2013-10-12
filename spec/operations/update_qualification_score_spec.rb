require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::UpdateQualificationScore do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('update_qualification_score', :operation => 'UpdateQualificationScore')
  end

  it "should ensure required params" do
    lambda{RTurk::UpdateQualificationScore()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'UpdateQualificationScore'))
    RTurk::UpdateQualificationScore(:qualification_type_id => '789RVWYBAZW00EXAMPLE',
                                  :subject_id => "ABCDEF1234",
                                  :integer_value => 80) rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    RTurk::UpdateQualificationScore(:qualification_type_id => '789RVWYBAZW00EXAMPLE',
                                  :subject_id => "ABCDEF1234",
                                  :integer_value => 80).elements.should eql(
      {"UpdateQualificationScoreResult"=>{"Request"=>{"IsValid"=>"True"}}})
  end
end

