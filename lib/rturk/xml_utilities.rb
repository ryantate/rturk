module RTurk::XMLUtilities

  def xml_to_hash(noko_xml)
    hash = {}
    noko_xml.children.each do |child|
      next if child.blank?
      if child.text?
        return child.text
      else
        hash[child.name] = xml_to_hash(child)
      end
    end
    hash
  end

  def map_content(xml_obj, hash)
    hash.each_pair do |k,v|
      val = xml_obj.xpath(v).inner_text.strip
      if val.match(/^[0-9]+$/)
        val = val.to_i
      elsif val.match(/^[0-9\.]+$/)
        val = val.to_f
      elsif val.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}T.+/)
        val =  Time.parse(val)
      end
      if self.respond_to?("#{k.to_s}=")
        self.send("#{k.to_s}=", val)
      else
        self.instance_variable_set("@#{k}", val)
      end
    end
  end

  # Takes a Rails-like nested param hash and normalizes it.
  def normalize_nested_params(hash)
    new_hash = {}
    hash.each do |k,v|
      inner_hash = new_hash
      keys = k.split(/[\[\]]/).reject{|s| s.nil? || s.empty? }
      keys[0...keys.size-1].each do |key|
        inner_hash[key] ||= {}
        inner_hash = inner_hash[key]
      end
      inner_hash[keys.last] = v
    end
    new_hash
  end

end
