require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetHIT do

  before(:all) do
    faker('get_hit', :operation => 'GetHIT')
  end

  it "should fetch the details of a HIT" do
    response = RTurk.GetHIT(:hit_id => '1234abcd')
    response.type_id.should eql('YGKZ2W5X6YFZ08ZRXXZZ')
    response.auto_approval_delay.should eql(3600)
    response.status.should eql('Reviewable')
    response.question_external_url.should eql("http://s3.amazonaws.com/mpercival.com/newtweet.html?id=foo")
    response.qualification_requirement_comparator.should eql("GreaterThan")
    response.qualification_requirement_value.should eql(90)
  end

  it "should not specify the ResponseGroup by default" do
    request = RTurk::GetHIT.new(:hit_id => '1234abcd')
    request.to_params["ResponseGroup"].should be_nil
  end

  it "should include the assignment summary in the response group if specified" do
    request = RTurk::GetHIT.new(:hit_id => '1234abcd', :include_assignment_summary => true)
    request.to_params["ResponseGroup"].should == {
      0 => "HITDetail", # default
      1 => "HITQuestion", # default
      2 => "Minimal", # default
      3 => "HITAssignmentSummary" # added
    }
  end

end