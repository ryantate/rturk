module RTurk

  # =The RTurk Hit Adapter
  # 
  # Lets us interact with Mechanical Turk without having to know all the operations.
  #
  # == Basic usage
  # @example
  #     require 'rturk'
  # 
  #     RTurk.setup(YourAWSAccessKeyId, YourAWSAccessKey, :sandbox => true)
  #     hit = RTurk::Hit.create(:title => "Add some tags to a photo") do |hit|
  #       hit.assignments = 2
  #       hit.question("http://myapp.com/turkers/add_tags")
  #       hit.reward = 0.05
  #       hit.qualifications.approval_rate, {:gt => 80}
  #     end
  #     
  #     hit.url #=>  'http://mturk.amazonaws.com/?group_id=12345678'
  
  
  class Hit
    include RTurk::XmlUtilities

    class << self;

      def create(*args, &blk)
        response = RTurk::CreateHIT(*args, &blk)
        response.hit
      end
      
      def find(id)
        
      end
      
      def all_reviewable
        RTurk.GetReviewableHITs.hits
      end
      
      def all
        RTurk.SearchHITs.hits
      end

    end

    attr_accessor :id

    def initialize(id, type = nil, xml_obj = nil)
      @id, @type = id, type
      if xml_obj
    end

    def assignments
      RTurk::GetAssignmentsForHIT(:hit_id => self.id).assignments
    end
    
    def details
      @details ||= RTurk::GetHIT(:hit_id => self.id)
    end
     
    def expire!
      RTurk::ForceExpireHIT(:hit_id => self.id)
    end
    
    def dispose!
      RTurk::DisposeHIT(:hit_id => self.id) 
    end
    
    def disable!
      RTurk::DisableHIT(:hit_id => self.id) 
    end


    def url
      if RTurk.sandbox?
        "http://workersandbox.mturk.com/mturk/preview?groupId=#{self.type_id}" # Sandbox Url
      else
        "http://mturk.com/mturk/preview?groupId=#{self.type_id}" # Production Url
      end
    end

    def method_missing(method, *args)
      if self.details.respond_to?(method)
        self.details.send(method, *args)
      end
    end


  end

end
