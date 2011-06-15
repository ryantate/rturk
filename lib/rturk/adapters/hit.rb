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
  #       hit.max_assignments = 2
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
        [].tap do |hits|
          RTurk.GetReviewableHITs.hit_ids.each do |hit_id|
            hits << new(hit_id)
          end
        end
      end

      def all
        [].tap do |hits|
          RTurk.SearchHITs.hits.each do |hit|
            hits << new(hit.id, hit)
          end
        end
      end

    end

    attr_accessor :id, :source

    def initialize(id, source = nil, options={})
      @id, @source = id, source
      @include_assignment_summary = options[:include_assignment_summary]
    end

    # memoing
    def assignments(options={})
      @assignments ||= {}

      @assignments[options] ||= begin
        assignments_options = options.update(:hit_id => self.id)
        
        RTurk::GetAssignmentsForHIT(assignments_options).assignments.inject([]) do |arr, assignment|
          arr << RTurk::Assignment.new(assignment.assignment_id, assignment)
        end
      end
    end

    def details
      @details ||= RTurk::GetHIT(:hit_id => self.id,
                                 :include_assignment_summary => !!@include_assignment_summary)
    end

    def extend!(options = {})
      RTurk::ExtendHIT(options.merge({:hit_id => self.id}))
    end

    def expire!
      RTurk::ForceExpireHIT(:hit_id => self.id)
    end

    def bonus_payments
      RTurk::GetBonusPayments(:hit_id => id).payments
    end

    def dispose!
      RTurk::DisposeHIT(:hit_id => self.id)
    end

    def disable!
      RTurk::DisableHIT(:hit_id => self.id)
    end

    def set_as_reviewing!
      RTurk::SetHITAsReviewing(:hit_id => self.id)
    end

    def set_as_reviewable!
      RTurk::SetHITAsReviewing(:hit_id => self.id, :revert => true)
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
      else
        super
      end
    end
  end
end
