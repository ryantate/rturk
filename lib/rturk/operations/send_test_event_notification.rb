module RTurk
  class SendTestEventNotification < Operation
    PARAMZ = [:notification, :test_event_type]

    attr_accessor *PARAMZ
    require_params *PARAMZ

    def to_params
      { :TestEventType => self.test_event_type }.
        merge(self.notification.to_param_hash)
    end
  end

  def self.SendTestEventNotification(*args)
    RTurk::SendTestEventNotification.create(*args)
  end
end
