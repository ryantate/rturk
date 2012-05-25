module RTurk::Utilities

  def camelize(phrase)
    phrase.gsub!(/^[a-z]|\_+[a-z]/) { |a| a.upcase }
    phrase.gsub!(/\_/, '')
    return phrase
  end

  def stringify_keys(ahash)
    ahash = ahash.inject({}) do |options, (key, value)|
      options[(key.to_s rescue key) || key] = value
      options
    end
    ahash
  end

  def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    else
      lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
    end
  end

  def underscore(camel_cased_word)
    camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
  
  # Executes the passed in block, retrying in cases of HTTP 503 Status Unvailable Errors
  def self.retry_on_unavailable(delay=1)
    begin
      yield
    rescue RTurk::ServiceUnavailable => e
      RTurk.logger.debug "HTTP Error 503: Service Unavailable.  Retrying in #{delay} seconds."
      sleep delay
      retry
    end
  end

end

# TODO: Build an Nokogiri from_xml parser, should return a hash
