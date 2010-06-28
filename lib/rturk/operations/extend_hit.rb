module RTurk
  class RTurk::ExtendHIT < RTurk::Operation
    
    attr_accessor :hit_id, :assignments, :seconds
    require_params :hit_id

    def to_params
      if assignments.nil? && seconds.nil?
        raise MissingParameters, 'Must add to either the HIT assignment count or expiration time.'
      end
      
      {'HITId' => self.hit_id,
       'MaxAssignmentsIncrement' => self.assignments,
       'ExpirationIncrementInSeconds' => self.seconds}
    end

  end

  def self.ExtendHIT(*args, &blk)
    RTurk::ExtendHIT.create(*args, &blk)
  end

end