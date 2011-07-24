require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'rturk/builders/answer_key_builder'

module RTurk
  describe AnswerKey do

    before(:all) do
    end

    class SillyAnswerKey < AnswerKey
      def answer_key_content
        Question "Why did the chicken cross the road?"
      end
    end

    it "is an abstract base class that calls down to 'answer_key_content' in its concrete subclasses" do
      RTurk::SillyAnswerKey.new.to_xml.should ==
        "<AnswerKey xmlns=\"#{RTurk::AnswerKey::XMLNS}\">" +
          "<Question>Why did the chicken cross the road?</Question>" +
        "</AnswerKey>"
    end

    # todo: test more

  end
end
