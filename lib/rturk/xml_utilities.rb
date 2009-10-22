module RTurk
  
  module XmlUtilities
    
    def xml_to_hash(noko_xml)
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
    
    def map_content(xml_obj, hash)
      hash.each_pair |k,v| do
        self.send("#{k.to_s}=", self.xml_obj.xpath(v).inner_text)
      end
    end
    
  end
  
end