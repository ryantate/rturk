module RTurk
  
  class SearchHITsResponse < Response
    
    def hits
      @hits ||= []
      @xml.xpath('//HIT').each do |hit_xml|
        @hits << RTurk::Hit.new(hit_xml.inner_text.strip)
      end
      @hits
    end
    
  end
  
end