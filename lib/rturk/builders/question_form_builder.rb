require 'cgi'
require 'uri'

module RTurk
  class QuestionForm

    XMLNS = "http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd"

    # The QuestionForm data structure is hella complicated, so we're just treating it as a string for now. See
    # http://docs.amazonwebservices.com/AWSMechTurk/2008-08-02/AWSMturkAPI/ApiReference_QuestionFormDataStructureArticle.html

    attr_accessor :text

    def initialize(text)
      @text = text
    end

    def to_params
      if text =~ /^<QuestionForm/
        text
      else
        <<-XML
<QuestionForm xmlns="#{XMLNS}">
#{text}
</QuestionForm>
        XML
      end
    end

  end


end
