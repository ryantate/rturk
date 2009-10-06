require 'cgi'

module RTurk
  class Question
    
    attr_accessor :url, :url_params, :frame_height
    
    def initialize(url = nil, opts = {})
      @url = url
      self.frame_height = opts.delete(:frame_height) || 400
      self.url_params = opts.dup
    end
    
    def querystring
      @url_params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
    end
    
    def url
      if querystring
        # slam the params onto url, if url already has params, add 'em with a &
        @url.index('?') ? "#{@url}&#{querystring}" : "#{@url}?#{querystring}" 
      end
    end
    
    
    def to_aws_params
      raise MissingURL, "needs a url to build an external question" unless @url
      # TODO: update the xmlns schema... maybe
      xml = <<-XML
<ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
	<ExternalURL>#{url}</ExternalURL>	
	<FrameHeight>#{frame_height}</FrameHeight>
</ExternalQuestion>
      XML
      xml
    end
    
  end
  
  
end