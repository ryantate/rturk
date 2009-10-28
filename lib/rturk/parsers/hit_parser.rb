#   <HIT>
#     <HITId>ZZRZPTY4ERDZWJ868JCZ</HITId>
#     <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
#     <CreationTime>2009-07-07T00:56:40Z</CreationTime>
#     <Title>Location</Title>
#     <Description>Select the image that best represents</Description>
#     <HITStatus>Assignable</HITStatus>
#     <MaxAssignments>1</MaxAssignments>
#     <Reward>
#       <Amount>5.00</Amount>
#       <CurrencyCode>USD</CurrencyCode>
#       <FormattedPrice>$5.00</FormattedPrice>
#     </Reward>
#     <AutoApprovalDelayInSeconds>2592000</AutoApprovalDelayInSeconds>
#     <Expiration>2009-07-14T00:56:40Z</Expiration>
#     <AssignmentDurationInSeconds>30</AssignmentDurationInSeconds>
#     <NumberOfAssignmentsPending>0</NumberOfAssignmentsPending>
#     <NumberOfAssignmentsAvailable>1</NumberOfAssignmentsAvailable>
#     <NumberOfAssignmentsCompleted>0</NumberOfAssignmentsCompleted>
#   </HIT>

module RTurk
  
  class HitParser
    include XmlUtilities
    
    attr_accessor :id, :type_id, :title, :description, :status
    
    def initialize(hit_xml)
      @xml_obj = hit_xml
      map_content(@xml_obj,
                  :id => 'HITId',
                  :type_id => 'HITTypeId',
                  :status => 'HITStatus',
                  :title => 'Title')
    end
    
    def created_at
      @created_at ||= Time.parse(@xml_obj.xpath('CreationTime').to_s)
    end

    def expires_at
      @expires_at ||= Time.parse(@xml_obj.xpath('Expiration').to_s)
    end
    
    def assignments_duration
      @assignments_duration ||= @xml_obj.xpath('AssignmentDurationInSeconds').inner_text.to_i
    end
    
    def number_of_assignments
      @number_of_assignments ||= @xml_obj.xpath('MaxAssignments').inner_text.to_i
    end

    def pending_assignments
      @pending_assignments ||= @xml_obj.xpath('NumberOfAssignmentsPending').inner_text.to_i
    end
    
    def available_assignments
      @available_assignments ||= @xml_obj.xpath('NumberOfAssignmentsAvailable').inner_text.to_i
    end
    
    def completed_assignments
      @completed_assignments ||= @xml_obj.xpath('NumberOfAssignmentsCompleted').inner_text.to_i
    end
    
    def auto_approval_delay
      @auto_approval_delay ||= @xml_obj.xpath('AutoApprovalDelayInSeconds').inner_text.to_i
    end
    
    def reward_amount
      @reward_amount ||= @xml_obj.xpath('Reward/Amount').inner_text.to_f
    end
  end
  
end