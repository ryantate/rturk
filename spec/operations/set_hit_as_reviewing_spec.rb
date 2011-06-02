require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::SetHITAsReviewing do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('set_hit_as_reviewing', :operation => 'SetHITAsReviewing')
  end

  it "should ensure required params" do
    lambda{RTurk::SetHITAsReviewing()}.should raise_error(RTurk::MissingParameters)
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).twice.with(
      hash_including('Operation' => 'SetHITAsReviewing'))
    RTurk::SetHITAsReviewing(:hit_id => "123456789") rescue RTurk::InvalidRequest
    RTurk::SetHITAsReviewing(:hit_id => "123456789", :revert => true) rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::SetHITAsReviewing(:hit_id => "123456789").should
      be_a_kind_of RTurk::Response
    RTurk::SetHITAsReviewing(:hit_id => "123456789", :revert => true).should
      be_a_kind_of RTurk::Response
  end

end
