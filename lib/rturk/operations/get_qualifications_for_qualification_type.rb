# Operation to get qualifications for a qualification type

module RTurk
  class GetQualificationsForQualificationType < Operation
    attr_accessor :qualification_type_id, :status, :page_size, :page_number
    require_params :qualification_type_id

    def parse(xml)
      RTurk::GetQualificationsForQualificationTypeResponse.new(xml)
    end

    def to_params
      params = {
        'QualificationTypeId' => qualification_type_id
      }
      params['Status'] = status unless status.nil?
      params['PageSize'] = page_size unless page_size.nil?
      params['PageNumber'] = page_number unless page_number.nil?
      params
    end
  end

  def self.GetQualificationsForQualificationType(*args)
    RTurk::GetQualificationsForQualificationType.create(*args)
  end
end