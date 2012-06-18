require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::QualificationTypeParser do
  
  before(:all) do
    @qualification_type_xml = <<-XML
<QualificationType>
    <QualificationTypeId>WKAZMYZDCYCZP412TZEZ</QualificationTypeId>
    <CreationTime>2009-05-17T10:05:15Z</CreationTime>
    <Name> WebReviews Qualification Master Test</Name>
    <Description>
    This qualification will allow you to earn more on the WebReviews HITs.
    </Description>
    <Keywords>WebReviews, webreviews, web reviews</Keywords>
    <QualificationTypeStatus>Active</QualificationTypeStatus>
      <Test>
        <QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
          <Overview>
          <Title>WebReviews Survey</Title>
          <Text>
          After you have filled out this survey you will be assigned one or more qualifications...
          </Text>
        </Overview>
        <Question>
          <QuestionIdentifier>age</QuestionIdentifier>
          <DisplayName>What is your age?</DisplayName>
          <IsRequired>true</IsRequired>
          <QuestionContent>
            <Text>
            Please choose the age group you belong to.
            </Text>
          </QuestionContent>
          <AnswerSpecification>
    		<SelectionAnswer>
    		  <StyleSuggestion>radiobutton</StyleSuggestion>
    		  <Selections>
    		    <Selection>
    		      <SelectionIdentifier>0018</SelectionIdentifier>
    		      <Text>-18</Text>
    		    </Selection>
  		    <Selection>
  		      <SelectionIdentifier>5160</SelectionIdentifier>
  		      <Text>51-60</Text>
  		    </Selection>
  		    <Selection>
  		      <SelectionIdentifier>6000</SelectionIdentifier>
  		      <Text>60+</Text>
  		    </Selection>
  		  </Selections>  
  	    </SelectionAnswer>
         </AnswerSpecification>
      </Question> 
    </QuestionForm>
    </Test>
    <TestDurationInSeconds>1200</TestDurationInSeconds>
  </QualificationType>
      XML
    @qualification_type_xml = Nokogiri::XML(@qualification_type_xml)
    @qualification_type = RTurk::QualificationTypeParser.new(@qualification_type_xml.children)
  end
  
  it "should parse an answer" do
    @qualification_type.qualification_type_id.should eql('WKAZMYZDCYCZP412TZEZ')
    @qualification_type.status.should eql('Active')
    @qualification_type.name.should eql('WebReviews Qualification Master Test')
    @qualification_type.keywords.should eql('WebReviews, webreviews, web reviews')
  end
end
