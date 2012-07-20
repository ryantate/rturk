require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::Assignment do
  describe "#bonus_payments" do
    it "should call GetBonusPayments with the assignment_id" do
      result = mock('result', :payments => [1, 2, 3])
      assignment = RTurk::Assignment.new(123456)
      RTurk.should_receive(:GetBonusPayments).
        with(:assignment_id => 123456).and_return(result)
      assignment.bonus_payments.should == result.payments
    end
  end

  describe "#approve_rejected!" do
    it "should call ApproveRejectedAssignment with assignment_id and optional feedback" do
      RTurk.should_receive(:ApproveRejectedAssignment).
        with(:assignment_id => 123456, :feedback => "abcde")
      assignment = RTurk::Assignment.new(123456)
      assignment.approve_rejected!("abcde")
    end
  end
end
