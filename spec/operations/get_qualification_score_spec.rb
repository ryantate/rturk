require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetQualificationScore do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_qualification_score', :operation => 'GetQualificationScore')
  end

  it "should ensure required params" do
    lambda{RTurk::GetQualificationScore()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GetQualificationScore'))
    RTurk::GetQualificationScore(:qualification_type_id => '789RVWYBAZW00EXAMPLE',
                                  :subject_id => "ABCDEF1234") rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    RTurk::GetQualificationScore(:qualification_type_id => '789RVWYBAZW00EXAMPLE',
                                  :subject_id => "ABCDEF1234").elements.should eql(
      {"GetQualificationScoreResult"=>
       {
        "Qualification" =>{
          "QualificationTypeId" => "789RVWYBAZW00EXAMPLE",
          "SubjectId" => "AZ3456EXAMPLE",
          "GrantTime" => "2005-01-31T23:59:59Z",
          "IntegerValue"=>"95"
        }
       }
      })
  end

  it "should pull out the attributes" do
    results = RTurk::GetQualificationScore(:qualification_type_id => '789RVWYBAZW00EXAMPLE',
                                  :subject_id => "AZ3456EXAMPLE")
    results.qualification_type_id.should eql('789RVWYBAZW00EXAMPLE')
    results.subject_id.should eql('AZ3456EXAMPLE')
    results.integer_value.should eql(95)
  end
end

