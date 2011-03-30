require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::RejectQualificationRequest do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('reject_qualification_request', :operation => 'RejectQualificationRequest')
  end

  it "should ensure required params" do
    lambda{RTurk::RejectQualificationRequest()}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'RejectQualificationRequest'))
    RTurk::RejectQualificationRequest(:qualification_request_id => "123456789", :reason => "Your work is terrible!") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::RejectQualificationRequest(:qualification_request_id => "123456789", :reason => "Your work is terrible!").should be_a_kind_of RTurk::Response
    RTurk::RejectQualificationRequest(:qualification_request_id => "789RVWYBAZW00EXAMPLE951RVWYBAZW00EXAMPLE").elements.should eql(
      {"RejectQualificationRequestResult"=>{"Request"=>{"IsValid"=>"True"}}}
    )
  end

end