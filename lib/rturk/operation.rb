module RTurk
  class Operation

    # This class is used to build more complicated requests
    # It must have a to_aws_params method which will be called
    # when it gets passed to Requester.
    # Optionally it may contain a response parser, which Requester
    # will call with the AWS response.

    # Take a look at the Hit requester for an example

    def parse(xml)
      # Override this in your operation if you like
      RTurk::Response.new(xml)
    end

    def credentials
      RTurk
    end

    def request
      parse(RTurk.Request(credentials.access_key, credentials.secret_key, credentials.host, to_params))
    end


  end
end
