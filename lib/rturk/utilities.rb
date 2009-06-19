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

end
