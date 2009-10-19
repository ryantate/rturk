module RTurk
  class GetAssignments < Operation

    operation 'GetAssignmentsForHIT'
    required_params 'Operation', 'HITId'
    

    def parse(xml)
      RTurk::GetAssignmentsResponse.new(xml)
    end

    private

      def operation_params
        {'Title'=>self.title,
         'MaxAssignments' => self.assignments,
         'LifetimeInSeconds'=> self.lifetime,
         'Reward.Amount' => self.reward,
         'Reward.CurrencyCode' => (self.currency || 'USD'),
         'Keywords' => self.keywords,
         'Description' => self.description,
         'RequesterAnnotation' => note}
      end

  end
  def self.GetAssignment(*args, &blk)
    RTurk::GetAssignment.create(*args, &blk)
  end

end
