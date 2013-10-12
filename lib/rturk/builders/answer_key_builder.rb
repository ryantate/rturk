require 'cgi'
require 'uri'
require "erector/xml_widget"

module RTurk
  # see http://docs.amazonwebservices.com/AWSMechTurk/2008-08-02/AWSMturkAPI/index.html?ApiReference_CreateQualificationTypeOperation.html
  class AnswerKey < Erector::XMLWidget

    XMLNS = "http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/AnswerKey.xsd"

    needs :xml => nil

    def to_params
      to_xml #create a new output string and call 'content' via Erector
    end

    %w{
  AnswerKey
    Question
      QuestionIdentifier
      AnswerOption
        SelectionIdentifier
        AnswerScore
      DefaultScore
    QualificationValueMapping
      PercentageMapping
        MaximumSummedScore
      ScaleMapping
        SummedScoreMultiplier
      RangeMapping
        SummedScoreRange
          InclusiveLowerBound
          InclusiveUpperBound
          QualificationValue
        OutOfRangeQualificationValue
    }.uniq.each do |element_name|
      tag element_name
      tag element_name, :snake_case unless element_name =='Text'
    end

    tag "Text", "text_element"  # very sticky since 'text' is a core Erector method

    def content
      if @xml and @xml.strip =~ /^<AnswerKey/
        rawtext @xml
      else
        answer_key :xmlns => XMLNS do
          answer_key_content
        end
      end
    end

    def answer_key_content
      rawtext @xml  # by default, use the parameter
    end
  end
end

