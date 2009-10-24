require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::GetHIT do

  before(:all) do
    faker('get_hit', :operation => 'GetHIT')
  end

  it "should fetch the details of a HIT" do
    response = RTurk.GetHIT(:hit_id => '1234abcd')
    response.type_id.should eql('NYVZTQ1QVKJZXCYZCZVZ')
    response.auto_approval.should eql(2592000)
    response.status.should eql('Assignable')
  end


end