require 'cgi'
require 'uri'

module RTurk
  class ExternalQuestion

    attr_accessor :url, :url_params, :frame_height

    def initialize(url, opts = {})
      @url = url
      self.frame_height = opts.delete(:frame_height) || 400
      self.url_params = opts
    end

    def querystring
      @url_params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
    end

    def url
      unless querystring.empty?
        # slam the params onto url, if url already has params, add 'em with a &
        u = @url.index('?') ? "#{@url}&#{querystring}" : "#{@url}?#{querystring}"
      else
        u = @url
      end
      CGI.escapeHTML(u) #URL should be XML/HTML escaped
    end

    def params
      @url_params
    end

    def params=(param_set)
      @url_params = param_set
    end

    def to_params
      raise RTurk::MissingParameters, "needs a url to build an external question" unless @url
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

  # TODO: Temporary alias for 2.11.x
  # Remove in next major version in favor of ExternalQuestion
  Question = ExternalQuestion
end
