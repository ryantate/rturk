# Parses the GetQualificationType Response
#
#  <GetQualificationScoreResult>
#    <Qualification>
#      <QualificationTypeId>789RVWYBAZW00EXAMPLE</QualificationTypeId>
#      <SubjectId>AZ3456EXAMPLE</SubjectId>
#      <GrantTime>2005-01-31T23:59:59Z</GrantTime>
#      <IntegerValue>95</IntegerValue>
#    </Qualification>
#  </GetQualificationScoreResult>

module RTurk
  class GetQualificationScoreResponse < Response
    attr_reader :qualification_type_id, :grant_time, :subject_id, :integer_value

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      map_content(@xml.xpath('//Qualification'),
        :qualification_type_id => 'QualificationTypeId',
        :subject_id => 'SubjectId',
        :grant_time => 'GrantTime',
        :integer_value => 'IntegerValue'
      )

    end
  end
end
