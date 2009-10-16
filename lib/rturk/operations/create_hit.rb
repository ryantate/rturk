module RTurk
  class CreateHit < Operation
    #
    # We perform the magic here to create a HIT with the minimum amount of fuss.
    # You should be able to pass in a hash with all the setting(ala YAML) or
    # do all the config in a block.
    #

    class << self
      attr_accessor :title, :keywords, :description, :reward, :currency, :assignments
      attr_accessor :lifetime, :duration, :auto_approval, :note, :qualifications


      def create(opts = {})
        opts.each_pair do |k,v|
          if self.respond_to?("#{k.to_sym}=")
            self.send "#{k}=".to_sym, v
          elsif self.respond_to?(k.to_sym)
            self.send k.to_sym, v
          end
        end
        yield(self) if block_given?
        RTurk::Response.new(request(self.to_aws_params))
      end

      def build

      end

      def qualification
        @qualifications ||= RTurk::Qualifications.new
      end

      def question
        @question ||=  RTurk::Question.new
      end

      def to_aws_params
        hit_params.merge(qualification.to_aws_params)
      end

      # def parse(xml)
      #   RTurk::CreateHitResponse.parse(xml)
      # end

      private

        def hit_params
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

  end
  def self.CreateHit(*args, &blk)
    RTurk::CreateHit.create(*args, &blk)
  end
  
end
