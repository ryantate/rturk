require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::GetAccountBalance do

  before(:all) do
    faker('get_account_balance')
  end

  it "should give me my account balance" do
    RTurk.GetAccountBalance.should eql(15555.55)
  end


end
