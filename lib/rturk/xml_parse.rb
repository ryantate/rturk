module RTurk
  
  class XMLParse
    
    def self.parse(noko_xml)
      hash = {}
      noko_xml.children.each do |child|
        next if child.blank?
        if child.text?
          return child.text
        else
          hash[child.name] = parse(child)
        end
      end
      hash
    end
    
  end
  
  def self.XMLParse(xml)
    RTurk::XMLParse.parse(xml)
  end
  
end