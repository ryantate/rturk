module RTurk
  class CreateHit < Operation
    #
    # We perform the magic here to create a HIT with the minimum amount of fuss.
    # You should be able to pass in a hash with all the setting(ala YAML) or
    # do all the config in a block.
    #

    attr_accessor :title, :keywords, :description, :reward, :currency, :assignments
    attr_accessor :lifetime, :duration, :auto_approval, :note


    def self.create(opts = {}, &blk)
      hit = self.new(opts, &blk)
      hit.request
    end

    def initialize(opts = {})
      opts.each_pair do |k,v|
        if self.respond_to?("#{k.to_sym}=")
          self.send "#{k}=".to_sym, v
        elsif v.is_a?(Array)
          v.each do |a|
            (self.send k.to_s).send a[0].to_sym, a[1]
          end
        elsif self.respond_to?(k.to_sym)
          self.send k.to_sym, v
        end
      end
      yield(self) if block_given?
      self
    end

    def qualifications
      @qualifications ||= RTurk::Qualifications.new
    end

    def question(*args)
      @question ||= RTurk::Question.new(*args)
    end

    def to_params
      hit_params.merge(qualifications.to_params).merge(question.to_params)
    end

    def parse(xml)
      RTurk::CreateHitResponse.new(xml)
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
         'RequesterAnnotation' => note}
      end

  end
  def self.CreateHit(*args, &blk)
    RTurk::CreateHit.create(*args, &blk)
  end

end
