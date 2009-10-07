module RTurk
  class Operation

    # This class is used to build more complicated requests
    # It must have a to_aws_params method which will be called
    # when it gets passed to Requester.
    # Optionally it may contain a response parser, which Requester
    # will call with the AWS response.

    # Take a look at the Hit requester for an example

  end
end
