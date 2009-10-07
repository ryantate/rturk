class Hit < RTurk::Operation
  #
  # We perform the magic here to create a HIT with the minimum amount of fuss.
  # You should be able to pass in a hash with all the setting(ala YAML) or
  # do all the config in a block.
  #


  attr_accessor :title, :keywords, :description, :reward, :currency, :assignments
  attr_accessor :lifetime, :duration, :auto_approval, :note, :qualifications


  def initialize(opts = {})
    opts.each_pair do |k,v|
      if self.respond_to?(k.to_sym)
        self.send "#{k}=".to_sym, v
      end
    end
    yield(self) if block_given?
  end
  
  def qualification
    @qualifications ||= RTurk::Qualifications.new
  end
  
  def question
    @question =  RTurk::Question.new
  end

  def to_aws_params
    hit_params.merge(@qualifications.to_aws_params)
  end
  
  def parse(results)
    RTurk.logger.debug(results)
  end
  
  private
  
  def hit_params
    {'Title'=>self.title, 
     'MaxAssignments' => self.assignments, 
     'LifetimeInSeconds'=> self.lifetime, 
     'Reward.Amount' => self.reward,
     'Reward.CurrencyCode' => (self.currency || 'USD'),
     'Keywords' => self.keywords, 
     'Description' => self.description,
     'RequesterAnnotation' => note,
     'AssignmentDurationInSeconds' => (duration || 3600), 
     'AutoApprovalDelayInSeconds' => (auto_approval || 3600)}
  end

end

