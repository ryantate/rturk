class Hit < RTurk::Request
  #
  # We perform the magic here to create a HIT with the minimum amount of fuss.
  # You should be able to pass in a hash with all the setting(ala YAML) or
  # do all the config in a block.
  #


  attr_accessors :title, :keywords, :description, :reward, :currency, :assignments
  attr_accessors :lifetime, :duration, :auto_approval, :note


  def initialize(opts = {})
    opts.each_pair do |k,v|
      #set the attr's to the opts
    end
    yield if block_given?
  end
  
  def qualification(method)
    qualifications ||= RTurk::Qualifications.new
  end
  
  def question
    @question =  RTurk::Question.new
  end

  def request

    yield if block_given?
  end

  def to_aws_params

  end
  
  def parse_results(results)
    HitResponse.new(results)
  end

end

class HitResponse < RTurk::Response
  
  def initialize(xml)
    
  end
  
end
