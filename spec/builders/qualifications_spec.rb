require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::Qualifications do
  
  before(:each) do
    @qualifications = RTurk::Qualifications.new
  end
  
  it "should build a qualification set with multiple qualifications" do
    @qualifications.add :approval_rate, {:gt => 80}
    @qualifications.approval_rate(:lt => 90)
    @qualifications.to_params['QualificationRequirement.1.Comparator'].should == 'GreaterThan'
    @qualifications.to_params['QualificationRequirement.2.IntegerValue'].should == 90
  end
  
  it "should build a qualification set with booleans" do
    @qualifications.add :adult, true
    @qualifications.to_params['QualificationRequirement.1.Comparator'].should == 'EqualTo'
    @qualifications.to_params['QualificationRequirement.1.IntegerValue'].should == 1
  end
  
  it "should build a qualification set with a country condition" do
    @qualifications.add :adult, true
    @qualifications.country :eql => 'US'
    @qualifications.to_params['QualificationRequirement.2.Comparator'].should == 'EqualTo'
    @qualifications.to_params['QualificationRequirement.2.LocaleValue.Country'].should == 'US'
  end
  
end