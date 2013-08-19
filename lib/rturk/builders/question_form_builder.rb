require 'cgi'
require 'uri'
require "erector/xml_widget"

module RTurk
  # see http://docs.amazonwebservices.com/AWSMechTurk/2008-08-02/AWSMturkAPI/ApiReference_QuestionFormDataStructureArticle.html
  # @param options hash (optional)
  # ::xml:: raw xml (optional). If it starts with \&lt;QuestionForm then it's used as the full QuestionForm value. Otherwise it is wrapped in a \&lt;QuestionForm\&gt; element. If it is nil then we use Erector to call its subclass' #question_form_content method.
  class QuestionForm < Erector::XMLWidget

    XMLNS = "http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd"

    needs :xml => nil

    def to_params
      to_xml  # create a new output string and call 'content' via Erector
    end

    # todo: fill out Application subelements
    # todo: fill out EmbeddedBinary subelements
    %w{
    QuestionForm
      Overview
        Title
        List
        Binary
          MimeType
            Type
            SubType
          DataURL
          AltText
        Application
        EmbeddedBinary
        FormattedContent

      Question
        QuestionIdentifier
        DisplayName
        IsRequired
        QuestionContent
        AnswerSpecification
          FreeTextAnswer
            Constraints
              IsNumeric
              Length
              AnswerFormatRegex
            DefaultText
            NumberOfLinesSuggestion
          SelectionAnswer
            MinSelectionCount
            MaxSelectionCount
            StyleSuggestion
            Selections
              Selection
                SelectionIdentifier
                  Text
                  FormattedContent
                  Binary
              OtherSelection
          FileUploadAnswer
            MaxFileSizeInBytes
            MinFileSizeInBytes
    }.uniq.each do |element_name|
      tag element_name
      tag element_name, :snake_case unless element_name == 'Text'
    end

    tag "Text", "text_element"  # very sticky since 'text' is a core Erector method

    def content
      if @xml and @xml.strip =~ /^<QuestionForm/
        rawtext @xml
      else
        question_form :xmlns => XMLNS do
          question_form_content
        end
      end
    end

    def question_form_content
      rawtext @xml  # by default, use the parameter
    end

  end

end
