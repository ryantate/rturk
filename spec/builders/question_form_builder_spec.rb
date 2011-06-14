require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::QuestionForm do

  before(:all) do
  end

  it "should build a question" do
    question = RTurk::QuestionForm.new("[...]")
    question.text.should == "[...]"
    question.to_params.should == <<-XML
<QuestionForm xmlns="#{RTurk::QuestionForm::XMLNS}">
[...]
</QuestionForm>
    XML
  end

end
