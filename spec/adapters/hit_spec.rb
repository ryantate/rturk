require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "HIT adapter" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit', :operation => 'CreateHIT')
    faker('get_hit', :operation => 'GetHIT')
    faker('get_reviewable_hits', :operation => 'GetReviewableHITs')

    faker('get_assignments', :operation => 'GetAssignments')

    faker('get_rejected_assignments', 
      :params => {"AssignmentStatus" => "Rejected"}
    )
    faker('get_submitted_assignments', 
      :params => {"AssignmentStatus" => "Submitted"}
    )
    faker('get_approved_assignments', 
      :params => {"AssignmentStatus" => "Approved"}
    )

    faker('extend_hit', :operation => 'ExtendHIT')
    faker('force_expire_hit', :operation => 'ForceExpireHIT')
    faker('dispose_hit', :operation => 'DisposeHIT')
    faker('set_hit_as_reviewing', :operation => 'SetHITAsReviewing')
    faker('search_hits', :operation => 'SearchHITs')
  end

  it "should let us create a hit" do
    RTurk::Hit.create(:title => 'foo', :description => 'do foo', :question => 'http://mpercival.com', :reward => 0.05)
  end

  describe "#bonus_payments" do
    it "should call GetBonusPayments with the hit_id" do
      result = mock('result', :payments => [1, 2, 3])
      hit = RTurk::Hit.new(12345)
      RTurk.should_receive(:GetBonusPayments).
        with(:hit_id => 12345).and_return(result)
      hit.bonus_payments.should == result.payments
    end
  end
  
  it "should retrieve all the details of a HIT with find" do
    proxy_hit = RTurk::Hit.new(12345)
    proxy_hit.should_receive(:details)
    proxy_hit.should_receive(:assignments)
    RTurk::Hit.should_receive(:new).and_return(proxy_hit)
    hit = RTurk::Hit.find(12345)
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

  context "assignment state" do
    it "finds approved", :focus => true do
      hits = RTurk::Hit.all_reviewable
      hits.first.assignments(:status => "Approved").first.answers["tweet"].should eql("I Was approved!")
    end

    it "finds rejected" do
      hits = RTurk::Hit.all_reviewable
      hits.first.assignments(:status => "Rejected").first.answers["tweet"].should eql("I was rejected!")
    end

    it "finds submitted" do
      hits = RTurk::Hit.all_reviewable
      hits.first.assignments(:status => "Submitted").first.answers["tweet"].should eql("I was submitted!")
    end
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

  it "should set a hit as Reviewing and Reviewable" do
    hit = RTurk::Hit.all_reviewable.first
    RTurk.should_receive(:SetHITAsReviewing).once.with(:hit_id => hit.id)
    hit.set_as_reviewing!
    RTurk.should_receive(:SetHITAsReviewing).once.with(:hit_id => hit.id, :revert => true)
    hit.set_as_reviewable!
  end

  it "should return a list of all hits" do
    hits = RTurk::Hit.all
    hits.size.should eql(2)
    hits.last.type_id.should eql('NYVZTQ1QVKJZXCYZCZVZ')
    hits.last.status.should eql('Assignable')
    hits.first.reward_amount.should eql(5.00)
    hits.first.completed_assignments.should eql(1)
  end

  it "should get normal details without specifying" do
    hit = RTurk::Hit.new(12345)
    RTurk.should_receive(:GetHIT).with(:hit_id => 12345,
                                       :include_assignment_summary => false)
    hit.details
  end

  it "should include assignment summary attributes in details if specified in initialize" do
    hit = RTurk::Hit.new(12345, nil, :include_assignment_summary => true)
    RTurk.should_receive(:GetHIT).with(:hit_id => 12345,
                                       :include_assignment_summary => true)
    hit.details
  end
end
