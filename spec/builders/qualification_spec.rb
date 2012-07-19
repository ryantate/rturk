require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::Qualifications do

  # Possible values coming back
  # {"QualificationTypeId","Comparator", "IntegerValue", "LocaleValue.Country","RequiredToPreview"}

  before(:each) do

  end

  it "should build a qualification for Approval rate" do
    @qualification = RTurk::Qualification.new('000000000000000000L0', :gt => 90)
    @qualification.to_params.should eql({"QualificationTypeId" => '000000000000000000L0',"Comparator" => 'GreaterThan',
                                         "IntegerValue" => 90, "RequiredToPreview" => "true"})
  end

  it "should build a qualification for Approval rate which does not require preview" do
    @qualification = RTurk::Qualification.new('000000000000000000L0', :gt => 90, "RequiredToPreview" => false)
    @qualification.to_params.should eql({"QualificationTypeId" => '000000000000000000L0',"Comparator" => 'GreaterThan',
                                         "IntegerValue" => 90, "RequiredToPreview" => 'false'})
  end

  it "should build a qualification for boolean qualification" do
    @qualification = RTurk::Qualification.new('00000000000000000060', true)
    @qualification.to_params.should eql({"QualificationTypeId" => '00000000000000000060',"Comparator" => 'EqualTo',
                                         "IntegerValue" => 1, "RequiredToPreview" => "true"})
  end

  it "should build a qualification for country qualification" do
    @qualification = RTurk::Qualification.new('00000000000000000071', :eql => 'PH')
    @qualification.to_params.should eql({"QualificationTypeId" => '00000000000000000071',"Comparator" => 'EqualTo',
                                         "LocaleValue.Country" => 'PH', "RequiredToPreview" => "true"})
  end

  it "should build a qualification for existence qualification" do
    @qualification = RTurk::Qualification.new('00000000000000000071', :exists => true)
    @qualification.to_params.should eql({"QualificationTypeId" => '00000000000000000071',"Comparator" => 'Exists',
                                         "RequiredToPreview" => "true"})
  end

  context 'passing in symbols representing a TypeID' do

    it "should build a qualification for Approval rate" do
      @qualification = RTurk::Qualification.new(:approval_rate, :gt => 90)
      @qualification.to_params.should eql({"QualificationTypeId" => '000000000000000000L0',"Comparator" => 'GreaterThan',
                                           "IntegerValue" => 90, "RequiredToPreview" => "true"})
    end

    it "should build a qualification for boolean qualification" do
      @qualification = RTurk::Qualification.new(:adult, true)
      @qualification.to_params.should eql({"QualificationTypeId" => '00000000000000000060',"Comparator" => 'EqualTo',
                                           "IntegerValue" => 1, "RequiredToPreview" => "true"})
    end

    it "should build a qualification for country qualification" do
      @qualification = RTurk::Qualification.new(:country, :eql => 'PH')
      @qualification.to_params.should eql({"QualificationTypeId" => '00000000000000000071',"Comparator" => 'EqualTo',
                                           "LocaleValue.Country" => 'PH', "RequiredToPreview" => "true"})
    end

  end

end
