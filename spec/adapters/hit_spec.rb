require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "HIT adapter" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit', :operation => 'CreateHIT')
    faker('get_hit', :operation => 'GetHIT')
    faker('get_reviewable_hits', :operation => 'GetReviewableHITs')
    faker('get_assignments', :operation => 'GetAssignments')
    faker('extend_hit', :operation => 'ExtendHIT')
    faker('force_expire_hit', :operation => 'ForceExpireHIT')
    faker('dispose_hit', :operation => 'DisposeHIT')
    faker('search_hits', :operation => 'SearchHITs')
  end

  it "should let us create a hit" do
    RTurk::Hit.create(:title => 'foo', :description => 'do foo', :question => 'http://mpercival.com', :reward => 0.05)
  end
  
  it "should automagically request additional information on an existing hit" do
    hit = RTurk::Hit.new(12345)
    hit.type_id.should eql("YGKZ2W5X6YFZ08ZRXXZZ")
    hit.url.should eql("http://workersandbox.mturk.com/mturk/preview?groupId=YGKZ2W5X6YFZ08ZRXXZZ")
  end
  
  it "should get all reviewable hits" do
    hits = RTurk::Hit.all_reviewable
    hits.size.should eql(3)
  end
  
  it "should find assignments for a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.assignments.first.answers["tweet"].should eql('This is my tweet!')
  end
  
  it "should add time to a hit" do 
    hits = RTurk::Hit.all_reviewable
    hits.first.extend! :seconds => 3600
  end
  
  it "should add assignments a hit" do 
    hits = RTurk::Hit.all_reviewable
    hits.first.extend! :assignments => 100
  end
  
  it "should expire a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.expire!
  end
  
  it "should dispose of a hit" do
    hits = RTurk::Hit.all_reviewable
    hits.first.dispose!
  end
  
  it "should return a list of all hits" do
    hits = RTurk::Hit.all
    hits.size.should eql(2)
    hits.last.type_id.should eql('NYVZTQ1QVKJZXCYZCZVZ')
    hits.last.status.should eql('Assignable')
    hits.first.reward_amount.should eql(5.00)
    hits.first.completed_assignments.should eql(1)
  end

end
