module RTurk
  Notification = Struct.new(:Destination, :Transport, :Version, :EventType) do
    # EventType can be a single string or an array of strings
    extend RTurk::Utilities

    members.each do |member|
      underscore = underscore(member)
      alias_method underscore, member
      alias_method "#{underscore}=", "#{member}="
    end

    def to_param_hash
      self.version = RTurk::OLD_API_VERSION # enforce this blindly

      hash = {}
      missing = []
      each_pair do |k, v|
        raise MissingParameters, "Missing parameter for #{k}" if v.nil?
        if (k == :EventType) && (v.is_a? Array)
            v.each_index do |i|
              hash["Notification.1.#{k}.#{i+1}"] = v[i]
            end
        else
          hash["Notification.1.#{k}"] = v
        end
      end
      hash
    end
  end
end
