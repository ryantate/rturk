# Parses the GetQualificationType Response

module RTurk
  class GetQualificationTypeResponse < Response
    attr_reader :qualification_type_id, :creation_time, :name, :description,
                :keywords, :status, :retry_delay_in_seconds, :is_requestable,
                :test, :test_duration_in_seconds, :answer_key, :auto_granted,
                :auto_granted_value

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//QualificationType'),
        :qualification_type_id => 'QualificationTypeId',
        :creation_time => 'CreationTime',
        :name => 'Name',
        :description => 'Description',
        :keywords => 'Keywords',
        :status => 'QualificationTypeStatus',
        :retry_delay_in_seconds => 'RetryDelayInSeconds',
        :is_requestable => 'IsRequestable',
        :test => 'Test',
        :test_duration_in_seconds => 'TestDurationInSeconds',
        :answer_key => 'AnswerKey',
        :auto_granted => 'AutoGranted',
        :auto_granted_value => 'AutoGrantedValue'
      )

      @keywords = @keywords.split(', ') if @keywords
    end
  end
end
