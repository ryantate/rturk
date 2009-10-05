module RTurk
  class Question
    
    attr_accessor :url, :url_params, :frame_height
    
    def initialize(opts = {})
      frame_height = opts[:frame_height] || 400
    end
    
    
    def to_aws_params
      frame_height = @frame_height || 400
      querystring = opts.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
      if self.url_params
        # slam the params onto url, if url already has params, add 'em with a &
        self.url = url.index('?') ? "#{url}&#{querystring}" : "#{url}?#{querystring}" 
      end
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