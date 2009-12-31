module RTurk
  Notification = Struct.new(:Destination, :Transport, :Version, :EventType) do
    extend RTurk::Utilities

    members.each do |member|
      underscore = underscore(member)
      alias_method underscore, member
      alias_method "#{underscore}=", "#{member}="
    end

    def to_param_hash
      self.version = '2006-05-05' # enforce this blindly

      hash = {}
      missing = []
      each_pair do |k, v|
        raise MissingParameters, "Missing parameter for #{k}" if v.nil?
        hash["Notification.1.#{k}"] = v
      end
      hash
    end
  end
end
