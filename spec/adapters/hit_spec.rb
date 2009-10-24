require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "HIT adapter" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit', :operation => 'CreateHIT')
    faker('get_hit', :operation => 'GetHIT')
    faker('get_reviewable_hits', :operation => 'GetReviewableHITs')
    faker('get_assignments', :operation => 'GetAssignments')
    faker('force_expire_hit', :operation => 'ForceExpireHIT')
    faker('dispose_hit', :operation => 'DisposeHIT')
  end

  it "should let us create a hit" do
    RTurk::Hit.create(:title => 'foo', :description => 'do foo', :question => 'http://mpercival.com', :reward => 0.05)
  end
  
  it "should automagically request additional information on an existing hit" do
    hit = RTurk::Hit.new(12345)
    hit.type_id.should eql("NYVZTQ1QVKJZXCYZCZVZ")
    hit.url.should eql("http://workersandbox.mturk.com/mturk/preview?groupId=NYVZTQ1QVKJZXCYZCZVZ")
  end
  
  it "should get all reviewable hits" do
    hits = RTurk::Hit.all_reviewable
    hits.size.should eql(3)
  end
  
  it "should find assignments for a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.assignments.first.answers["Question1"].should eql('Move to X.')
  end
  
  it "should expire a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.expire!
  end
  
  it "should dispose of a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.dispose!
  end

end
