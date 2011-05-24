require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetBonusPayments do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end

  context "a HIT with multiple payments" do
    before(:all) do
      WebMock.reset!
      faker('get_bonus_payments', :operation => 'GetBonusPayments')

      @response = RTurk::GetBonusPayments(:hit_id => 'fdsa')
    end

    it "should return 3 payments" do
      @response.payments.should have(3).things
    end

    it "should parse each payment correctly" do
      payment = @response.payments.first
      payment.bonus_amount.should == 0.04
      payment.currency_code.should == 'USD'
      payment.assignment_id.should == '180E4LY5TVT3R8QIIGL8GNEZWCF0UF'
      payment.reason.should == "Congrats! You earned a $0.04 bonus!"
      payment.grant_time.should < Time.now
    end

    it "should have unique assignment IDs" do
      ids = @response.payments.collect { |p| p.assignment_id }.uniq
      ids.should have(3).things
    end
  end
end
