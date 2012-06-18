require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::QualificationParser do
  
  before(:all) do
    @qualification_xml = <<-XML
<Qualification>
  <QualificationTypeId>789RVWYBAZW00EXAMPLE</QualificationTypeId>
  <SubjectId>AZ3456EXAMPLE</SubjectId>
  <GrantTime>2005-01-31T23:59:59Z</GrantTime>
  <IntegerValue>95</IntegerValue>
</Qualification>
      XML
    @qualification_xml = Nokogiri::XML(@qualification_xml)
    @qualification = RTurk::QualificationParser.new(@qualification_xml.children)
  end
  
  it "should parse an answer" do
    @qualification.qualification_type_id.should eql('789RVWYBAZW00EXAMPLE')
    @qualification.subject_id.should eql('AZ3456EXAMPLE')
  end
end
