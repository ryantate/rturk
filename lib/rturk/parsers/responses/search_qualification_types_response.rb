module RTurk
  # <SearchQualificationTypesResult>
  #   <Request>
  #     <IsValid>True</IsValid>
  #   </Request>
  #   <NumResults>10</NumResults>
  #   <TotalNumResults>5813</TotalNumResults>
  #   <QualificationType>
  #     <QualificationTypeId>WKAZMYZDCYCZP412TZEZ</QualificationTypeId>
  #     <CreationTime>2009-05-17T10:05:15Z</CreationTime>
  #     <Name> WebReviews Qualification Master Test</Name>
  #     <Description>
  #       This qualification will allow you to earn more on the WebReviews HITs.
  #     </Description>
  #     <Keywords>WebReviews, webreviews, web reviews</Keywords>
  #     <QualificationTypeStatus>Active</QualificationTypeStatus>
  #     <Test>
  #       <QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
  #         <Overview>
  #         <Title>WebReviews Survey</Title>
  #         <Text>
  #           After you have filled out this survey you will be assigned one or more qualifications...
  #         </Text>
  #         </Overview>
  #         <Question>
  #           <QuestionIdentifier>age</QuestionIdentifier>
  #           <DisplayName>What is your age?</DisplayName>
  #           <IsRequired>true</IsRequired>
  #           <QuestionContent>
  #             <Text>
  #               Please choose the age group you belong to.
  #             </Text>
  #           </QuestionContent>
  #           <AnswerSpecification>
  #             <SelectionAnswer>
  #               <StyleSuggestion>radiobutton</StyleSuggestion>
  #               <Selections>
  #                 <Selection>
  #                   <SelectionIdentifier>0018</SelectionIdentifier>
  #                   <Text>-18</Text>
  #                 </Selection>
  #                 <Selection>
  #                   <SelectionIdentifier>5160</SelectionIdentifier>
  #                   <Text>51-60</Text>
  #                 </Selection>
  #                 <Selection>
  #                   <SelectionIdentifier>6000</SelectionIdentifier>
  #                   <Text>60+</Text>
  #                 </Selection>
  #               </Selections>  
  #             </SelectionAnswer>
  #           </AnswerSpecification>
  #         </Question> 
  #       </QuestionForm>
  #     </Test>
  #     <TestDurationInSeconds>1200</TestDurationInSeconds>
  #   </QualificationType>
  #</SearchQualificationTypesResult>
  
  class SearchQualificationTypesResponse < Response
    
    attr_reader :num_results, :total_num_results, :page_number

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//SearchQualificationTypesResult'),
        :num_results => 'NumResults',
        :total_num_results => 'TotalNumResults',
        :page_number => 'PageNumber'
      )
    end
    
    def qualification_types
      @qualification_types ||= []
      @xml.xpath('//QualificationType').each do |qualification_type_xml|
        @qualification_types << QualificationTypeParser.new(qualification_type_xml)
      end
      @qualification_types
    end

  end
  
end