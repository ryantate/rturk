require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "HIT adapter" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit', :operation => 'CreateHIT')
    faker('get_hit', :operation => 'GetHIT')
  end

  it "should let us create a hit" do
    RTurk::Hit.create(:title => 'foo', :description => 'do foo', :question => 'http://mpercival.com', :reward => 0.05)
  end
  
  it "should automagically request additional information on an existing hit" do
    hit = RTurk::Hit.new(12345)
    hit.type_id.should eql("NYVZTQ1QVKJZXCYZCZVZ")
  end
  
  it "should get all reviewable hits"
  
  it "should find assignments for a hit"
  
  it "should expire a hit"
  
  it "should dispose of a hit"

end
