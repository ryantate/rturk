require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::GetHIT do

  before(:all) do
    faker('get_hit', :operation => 'GetHIT')
  end

  it "should fetch the details of a HIT" do
    response = RTurk.GetHIT(:hit_id => '1234abcd')
    response.type_id.should eql('YGKZ2W5X6YFZ08ZRXXZZ')
    response.auto_approval.should eql(3600)
    response.status.should eql('Reviewable')
  end


end