require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::Assignment do
  describe "#bonus_payments" do
    it "should call GetBonusPayments with the assignment_id" do
      result = mock('result', :payments => [1, 2, 3])
      hit = RTurk::Assignment.new(123456)
      RTurk.should_receive(:GetBonusPayments).
        with(:assignment_id => 123456).and_return(result)
      hit.bonus_payments.should == result.payments
    end
  end
end
