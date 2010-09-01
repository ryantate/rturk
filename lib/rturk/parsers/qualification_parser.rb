# Parses a Qualification object

module RTurk
  class QualificationParser < RTurk::Parser
    attr_reader :qualification_type_id, :subject_id, :grant_time,
                :integer_value, :locale_value, :status

    def initialize(qualifications_xml)
      @xml_obj = qualifications_xml
      map_content(@xml_obj,
                  :qualification_type_id => 'QualificationTypeId',
                  :subject_id => 'SubjectId',
                  :grant_time => 'GrantTime',
                  :integer_value => 'IntegerValue',
                  :locale_value => 'LocaleValue',
                  :status => 'Status')
    end
  end
end
