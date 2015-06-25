module RTurk

  class AnswerParser

    require 'cgi'

    def self.parse(xml)
      answer_xml = Nokogiri::XML(CGI.unescapeHTML(xml.to_s))
      answer_hash = {}
      answers = answer_xml.xpath('//xmlns:Answer')
      answers.each do |answer|
        key, values = nil, []
        answer.children.each do |child|
          next if child.blank?
          if child.name == 'QuestionIdentifier'
            key = child.inner_text
          else
            values << child.inner_text
          end
        end
        answer_hash[key] = values.count==1 ? values[0] : values
      end
      answer_hash
    end


  end

end