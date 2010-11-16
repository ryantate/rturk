module RTurk
  class GetHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id, :include_assignment_summary

    def parse(xml)
      RTurk::GetHITResponse.new(xml)
    end

    def to_params
      params = {"HITId" => self.hit_id}

      if @include_assignment_summary
        params["ResponseGroup"] = {
          0 => "HITDetail", # default
          1 => "HITQuestion", # default
          2 => "Minimal", # default
          3 => "HITAssignmentSummary" # added
        }
      end

      params
    end

  end

  def self.GetHIT(*args, &blk)
    RTurk::GetHIT.create(*args, &blk)
  end

end