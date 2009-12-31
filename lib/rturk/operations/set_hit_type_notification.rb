module RTurk
  class SetHITTypeNotification < Operation
    PARAMZ = [:hit_type_id, :notification, :active]

    attr_accessor *PARAMZ
    require_params *PARAMZ

    def to_params
      { :HITTypeId => self.hit_type_id,
        :Active => self.active }.
        merge(self.notification.to_param_hash)
    end
  end

  def self.SetHITTypeNotification(*args)
    RTurk::SetHITTypeNotification.create(*args)
  end
end
