require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::HITParser do
  
  before(:all) do
    @hit_xml = <<-XML
<HIT>
  <HITId>ZZRZPTY4ERDZWJ868JCZ</HITId>
  <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
  <CreationTime>2009-07-07T00:56:40Z</CreationTime>
  <Title>Location</Title>
  <Description>Select the image that best represents</Description>
  <HITStatus>Assignable</HITStatus>
  <MaxAssignments>1</MaxAssignments>
  <Reward>
    <Amount>5.00</Amount>
    <CurrencyCode>USD</CurrencyCode>
    <FormattedPrice>$5.00</FormattedPrice>
  </Reward>
  <AutoApprovalDelayInSeconds>2592000</AutoApprovalDelayInSeconds>
  <Expiration>2009-07-14T00:56:40Z</Expiration>
  <AssignmentDurationInSeconds>30</AssignmentDurationInSeconds>
  <NumberOfAssignmentsPending>0</NumberOfAssignmentsPending>
  <NumberOfAssignmentsAvailable>1</NumberOfAssignmentsAvailable>
  <NumberOfAssignmentsCompleted>0</NumberOfAssignmentsCompleted>
</HIT>
      XML
    @hit_xml = Nokogiri::XML(@hit_xml)
    @hit = RTurk::HITParser.new(@hit_xml.children)
  end
  
  it "should parse an answer" do
    @hit.id.should eql('ZZRZPTY4ERDZWJ868JCZ')
    @hit.type_id.should eql('NYVZTQ1QVKJZXCYZCZVZ')
    @hit.status.should eql('Assignable')
    @hit.reward_amount.should eql(5.00)
  end
end
