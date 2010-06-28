require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::ExtendHIT do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('extend_hit', :operation => 'ExtendHIT')
  end

  it "should ensure required params" do
    lambda{RTurk::ExtendHIT(:hit_id => "123456789")}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'ExtendHIT'))
    RTurk::ExtendHIT(:hit_id => "123456789", :assignments=> 1) rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::ExtendHIT(:hit_id => "123456789", :seconds => 3600).should
      be_a_kind_of RTurk::Response
  end

end