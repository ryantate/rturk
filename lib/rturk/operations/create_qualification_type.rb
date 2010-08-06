# Operation to create a qualification type

module RTurk
  class CreateQualificationType < Operation
    attr_accessor :name, :description, :keywords, :status, :auto_granted,
                  :retry_delay_in_seconds, :test, :answer_key,
                  :test_duration_in_seconds, :auto_granted_value
    require_params :name, :description

    def parse(response)
      RTurk::GetQualificationTypeResponse.new(response)
    end

    def to_params
      params = {
        'Name' => name,
        'Description' => description,
        'QualificationTypeStatus' => (status || "Active")
      }
      params['Keywords'] = keywords unless keywords.nil?
      params['AutoGranted'] = auto_granted unless auto_granted.nil?
      params['AutoGrantedValue'] = auto_granted_value unless auto_granted_value.nil?
      params['RetryDelayInSeconds'] = retry_delay_in_seconds unless retry_delay_in_seconds.nil?
      params['Test'] = test unless test.nil?
      params['AnswerKey'] = answer_key unless answer_key.nil?
      params['TestDurationInSeconds'] = test_duration_in_seconds unless test_duration_in_seconds.nil?
      params
    end
  end

  def self.CreateQualificationType(*args)
    RTurk::CreateQualificationType.create(*args)
  end
end