require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::GetAccountBalance do

  before(:all) do
    faker('get_account_balance', :operation => 'GetAccountBalance')
  end

  it "should give me my account balance" do
    RTurk.GetAccountBalance.amount.should eql(15555.55)
  end


end
