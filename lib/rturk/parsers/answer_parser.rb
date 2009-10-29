module RTurk

  class AnswerParser

    require 'cgi'

    def self.parse(xml)
      answer_xml = Nokogiri::XML(CGI.unescapeHTML(xml.to_s))
      answer_hash = {}
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
        answer_hash[key] = value
      end
      answer_hash
    end


  end

end