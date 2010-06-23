module RTurk
  class RTurk::ExtendHIT < RTurk::Operation
    
    attr_accessor :hit_id, :max_assignments_increment, :expiration_increment_in_seconds 
    require_params :hit_id

    def to_params
      if max_assignments_increment.nil? && expiration_increment_in_seconds.nil?
        raise MissingParameters, 'Must add to either the HIT assignment count or expiration time.'
      end
      
      {'HITId' => self.hit_id,
       'MaxAssignmentsIncrement' => self.max_assignments_increment,
       'ExpirationIncrementInSeconds' => self.expiration_increment_in_seconds}
    end

  end

  def self.ExtendHIT(*args, &blk)
    RTurk::ExtendHIT.create(*args, &blk)
  end

end