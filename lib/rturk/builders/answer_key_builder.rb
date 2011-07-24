require "erector/xml_widget"

# see http://docs.amazonwebservices.com/AWSMechTurk/2008-08-02/AWSMturkAPI/index.html?ApiReference_CreateQualificationTypeOperation.html
class RTurk::AnswerKey < Erector::XMLWidget

  XMLNS = "http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/AnswerKey.xsd"

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
    tag element_name, :snake_case
  end

  def content
    answer_key :xmlns => XMLNS do
      answer_key_content
    end
  end

end

