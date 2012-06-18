module RTurk
  class GetAssignment < Operation
    require_params :assignment_id
    attr_accessor  :assignment_id

    def parse(xml)
      GetAssignmentResponse.new(xml)
    end

    def to_params
      {'AssignmentId' => assignment_id}
    end
  end

  def self.GetAssignment(*args, &blk)
    RTurk::GetAssignment.create(*args, &blk)
  end
end
