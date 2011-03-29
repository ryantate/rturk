# Parses a QualificationRequest object

module RTurk
  class QualificationRequestParser < RTurk::Parser
    attr_reader :qualification_request_id, :qualification_type_id, :subject_id, 
                :submit_time, :test, :answer

    def initialize(qualification_request_xml)
      @xml_obj = qualification_request_xml
      map_content(@xml_obj,
                  :qualification_request_id => 'QualificationRequestId',
                  :qualification_type_id => 'QualificationTypeId',
                  :subject_id => 'SubjectId',
                  :submit_time => 'SubmitTime',
                  :test => 'Test',
                  :answer => 'Answer')
    end
  end
end