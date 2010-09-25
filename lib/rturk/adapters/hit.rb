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
    include RTurk::XMLUtilities

    class << self
      def create(*args, &blk)
        response = RTurk::CreateHIT(*args, &blk)
        new(response.hit_id, response)
      end

      # Find all the details for a HIT
      # You could do this manually with new(id), and only call for the details
      # you need, or simply call this and get them all, and immediately see
      # any errors
      def find(id)
        h = new(id)
        h.details
        h.assignments
        h
      end

      def all_reviewable
        RTurk.GetReviewableHITs.hit_ids.inject([]) do |arr, hit_id|
          arr << new(hit_id); arr
        end
      end

      def all
        RTurk.SearchHITs.hits.inject([]) do |arr, hit|
          arr << new(hit.id, hit); arr;
        end
      end

    end

    attr_accessor :id, :source

    def initialize(id, source = nil)
      @id, @source = id, source
    end

    # memoing
    def assignments
      @assignments ||=
        RTurk::GetAssignmentsForHIT(:hit_id => self.id).assignments.inject([]) do |arr, assignment|
          arr << RTurk::Assignment.new(assignment.assignment_id, assignment)
        end
    end

    def details
      @details ||= RTurk::GetHIT(:hit_id => self.id)
    end

    def extend!(options = {})
      RTurk::ExtendHIT(options.merge({:hit_id => self.id}))
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
      if @source.respond_to?(method)
        @source.send(method, *args)
      elsif self.details.respond_to?(method)
        self.details.send(method)
      end
    end


  end

end
