# Operation to update a qualification type

module RTurk
  class UpdateQualificationType < Operation
    attr_accessor :qualification_type_id, :name, :description, :keywords,
                  :status, :auto_granted, :retry_delay_in_seconds,
                  :test, :answer_key, :test_duration_in_seconds,
                  :auto_granted_value
    require_params :qualification_type_id

    def parse(xml)
      RTurk::GetQualificationTypeResponse.new(xml)
    end

    def to_params
      params = {
        'QualificationTypeId' => qualification_type_id
      }
      params['Name'] = name unless name.nil?
      params['Description'] = description unless description.nil?
      params['Keywords'] = keywords unless keywords.nil?
      params['QualificationTypeStatus'] = status unless status.nil?
      params['AutoGranted'] = auto_granted unless auto_granted.nil?
      params['RetryDelayInSeconds'] = retry_delay_in_seconds unless retry_delay_in_seconds.nil?
      params['Test'] = test unless test.nil?
      params['AnswerKey'] = answer_key unless answer_key.nil?
      params['TestDurationInSeconds'] = test_duration_in_seconds unless test_duration_in_seconds.nil?
      params['AutoGrantedValue'] = auto_granted_value unless auto_granted_value.nil?
      params
    end
  end

  def self.UpdateQualificationType(*args)
    RTurk::UpdateQualificationType.create(*args)
  end
end