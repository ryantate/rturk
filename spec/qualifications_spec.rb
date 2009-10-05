require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Qualifications do
  
  before(:each) do
    @qualifications = RTurk::Qualifications.new
  end
  
  it "should build a qualification for Approval rate" do
    @qualifications.approval_rate(:gt => 80)
    @qualifications.to_aws_params['QualificationRequirement.1.Comparator'].should == 'GreaterThan'
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should == 80
  end
  
  it "should also work for countries" do
    @qualifications.country(:eql => 'PH')
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should be_nil
    @qualifications.to_aws_params['QualificationRequirement.1.LocaleValue.Country'].should == 'PH'
  end
  
  it "should also work for booleans like adult" do
    @qualifications.adult(:eql => true)
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should == 1
    @qualifications.to_aws_params['QualificationRequirement.1.Comparator'].should == "EqualTo"
  end
  
  it "should also work for booleans without a given comparator" do
    @qualifications.adult(true)
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should == 1
    @qualifications.to_aws_params['QualificationRequirement.1.Comparator'].should == "EqualTo"
  end
  
  it "should allow custom requirements" do
    @qualifications.add(:type_id => '1234567', :lt => 90)
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should == 90
    @qualifications.to_aws_params['QualificationRequirement.1.QualificationTypeId'].should == '1234567'
  end
  
  it "should allow custom types to be added" do
    @qualifications.add(:type_id => '1234567', :lt => 90)
    @qualifications.to_aws_params['QualificationRequirement.1.IntegerValue'].should == 90
    @qualifications.to_aws_params['QualificationRequirement.1.QualificationTypeId'].should == '1234567'
  end
  
  it "should allow more than one requirement" do
    @qualifications.country(:eql => 'PH')
    @qualifications.approval_rate(:gt => 80)
    @qualifications.to_aws_params['QualificationRequirement.1.LocaleValue.Country'].should == 'PH'
    @qualifications.to_aws_params['QualificationRequirement.1.QualificationTypeId'].should == '00000000000000000071'
    @qualifications.to_aws_params['QualificationRequirement.2.IntegerValue'].should == 80
  end
  
end