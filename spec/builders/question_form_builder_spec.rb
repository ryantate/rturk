require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rturk/builders/question_form_builder'

module RTurk
  describe QuestionForm do

    before(:all) do
    end

    it "should build a question, using its xml param as the full QuestionForm since it starts with <QuestionForm" do
      xml = <<-XML
      <QuestionForm xmlns="#{RTurk::QuestionForm::XMLNS}">
      [...]
      </QuestionForm>
      XML
      question = RTurk::QuestionForm.new(:xml => xml)
      question.to_params.should == xml
    end

    it "should build a question, using its xml param as the QuestionForm content" do
      question = RTurk::QuestionForm.new(:xml => "[...]")
      question.to_params.should ==
        "<QuestionForm xmlns=\"#{RTurk::QuestionForm::XMLNS}\">[...]</QuestionForm>"
    end

    class SillyQuestionForm < QuestionForm
      def question_form_content
        Question "Why did the chicken cross the road?"
      end
    end

    it "is an abstract base class that calls down to 'question_form_content' in its concrete subclasses" do
      RTurk::SillyQuestionForm.new.to_xml.should ==
        "<QuestionForm xmlns=\"#{RTurk::QuestionForm::XMLNS}\">" +
          "<Question>Why did the chicken cross the road?</Question>" +
        "</QuestionForm>"
    end

    class AnotherSillyQuestionForm < QuestionForm
      def question_form_content
        question {
          question_content {
            Text "How many licks?" # note: Text vs text vs text_element gotcha
          }
          answer_specification {
            free_text_answer {
              constraints {
                is_numeric true
              }
            }
          }
        }
      end
    end

    it "allows snake_case element names" do
      RTurk::AnotherSillyQuestionForm.new.to_xml.should ==
        "<QuestionForm xmlns=\"#{RTurk::QuestionForm::XMLNS}\">" +
          "<Question>" +
            "<QuestionContent>" +
              "<Text>How many licks?</Text>" +
            "</QuestionContent>" +
            "<AnswerSpecification>" +
              "<FreeTextAnswer>" +
                "<Constraints>" +
                  "<IsNumeric>true</IsNumeric>" +
                "</Constraints>" +
              "</FreeTextAnswer>" +
            "</AnswerSpecification>" +
          "</Question>" +
        "</QuestionForm>"
    end

  end
end
