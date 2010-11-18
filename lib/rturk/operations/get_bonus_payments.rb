module RTurk
  class GetBonusPayments < Operation
    attr_accessor :hit_id, :assignment_id, :page_size,
                  :page_number

    def parse(xml)
      GetBonusPaymentsResponse.new(xml)
    end

    def to_params
      params = {
        'PageSize' => (page_size || 100),
        'PageNumber' => (page_number || 1)
      }
      
      params['HITId'] = hit_id if hit_id
      params['AssignmentId'] = assignment_id if assignment_id

      params
    end
  end

  def self.GetBonusPayments(*args, &block)
    RTurk::GetBonusPayments.create(*args, &block)
  end
end
