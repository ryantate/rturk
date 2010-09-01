require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetQualificationsForQualificationType do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('get_qualifications_for_qualification_type', :operation => 'GetQualificationsForQualificationType')
  end

  it "should ensure required params" do
    lambda{RTurk::GetQualificationsForQualificationType()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GetQualificationsForQualificationType'))
    RTurk::GetQualificationsForQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE') rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::GetQualificationsForQualificationType(:qualification_type_id => '789RVWYBAZW00EXAMPLE')
    response.num_results.should == 2
    response.qualifications.length.should == 2
    response.qualifications[0].subject_id.should == 'AZ3456EXAMPLE'
    response.qualifications[1].subject_id.should == 'AZ4567EXAMPLE'
  end
end