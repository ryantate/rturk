require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GrantBonus do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('grant_bonus', :operation => 'GrantBonus')
  end

  it "should ensure required params" do
    lambda{RTurk::GrantBonus(:assignment_id => "123456789")}.should raise_error RTurk::MissingParameters
  end
  
  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'GrantBonus'))
    RTurk::GrantBonus(:assignment_id => "123456789", 
                      :feedback => "Here's a quarter",
                      :worker_id => 'jerry',
                      :amount => 0.25) rescue RTurk::InvalidRequest
  end
  
  it "should parse and return the result" do
    RTurk::GrantBonus(:assignment_id => "123456789", 
                      :feedback => "Here's a quarter",
                      :worker_id => 'jerry',
                      :amount => 0.25).should
                      be_a_kind_of RTurk::Response
  end

end