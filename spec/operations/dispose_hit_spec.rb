require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::DisposeHIT do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('dispose_hit', :operation => 'DisposeHIT')
  end

  it "should ensure required params" do
    lambda{RTurk::DisposeHIT()}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'DisposeHIT'))
    RTurk::DisposeHIT(:hit_id => "123456789") rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::DisposeHIT(:hit_id => "123456789").should
      be_a_kind_of RTurk::Response
  end

end