require 'cgi'

module RTurk
  class Answers

    attr_accessor :answer_hash

    def initialize(xml)
      answer_xml = Nokogiri::XML(CGI.unescapeHTML(xml))
      @answer_hash = {}
      answers = answer_xml.xpath('//xmlns:Answer')
      answers.each do |answer|
        key, value = nil, nil
        answer.children.each do |child|
          next if child.blank?
          if child.name == 'QuestionIdentifier'
            key = child.inner_text
          else
            value = child.inner_text
          end
        end
        @answer_hash[key] = value
      end
    end
    
    
    # @param [<String, Symbol>] The string or symbol of the question name
    # @return [String] The value of the question name
    def [](key)
      @answer_hash[key]
    end
    
    def to_hash
      @answer_hash
    end

  end
end
