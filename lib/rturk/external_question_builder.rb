module RTurk
  class ExternalQuestionBuilder
    
    
    def self.build(url, opts = {})
      frame_height = opts[:frame_height] || 400
      opts.delete(:frame_height)
      querystring = opts.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
      url = opts.empty? ? url : "#{url}?#{querystring}"
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