module RTurk

  class Qualification

    # For more information about qualification requirements see:
    # http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/index.html?ApiReference_QualificationRequirementDataStructureArticle.html
    #

    COMPARATORS = {:gt => 'GreaterThan', :lt => 'LessThan', :gte => 'GreaterThanOrEqualTo',
                   :lte => 'LessThanOrEqualTo', :eql => 'EqualTo', :not => 'NotEqualTo', :exists => 'Exists'}

    def self.types
      system_qualification_types ||= {
        :approval_rate => '000000000000000000L0', :submission_rate => '00000000000000000000',
        :abandoned_rate => '00000000000000000070', :return_rate => '000000000000000000E0',
        :rejection_rate => '000000000000000000S0', :hits_approved => '00000000000000000040',
        :adult => '00000000000000000060', :country => '00000000000000000071',
      }

      # Amazon Master qualification ids vary between sandbox and real environments - see https://forums.aws.amazon.com/thread.jspa?threadID=70812
      system_qualification_types.merge(if RTurk.sandbox?
        {
          :categorization_masters => '2F1KVCNHMVHV8E9PBUB2A4J79LU20F',
          :photo_moderation_masters => '2TGBB6BFMFFOM08IBMAFGGESC1UWJX',
        }
      else
        {
          :categorization_masters => '2NDP2L92HECWY8NS8H3CK0CP5L9GHO',
          :photo_moderation_masters => '21VZU98JHSTLZ5BPP4A9NOBJEK3DPG',
        }
      end)
    end


    attr_accessor :qualifier

    # Builds the basic requirements for a qualification
    # needs at the minimum
    #  type_id, :comparator => :value
    #  or
    #  type_id, :exists => true
    #  or
    #  type_id, true
    #
    def initialize(type, opts)
      # If the value is a string, we can assume it's the country since,
      # Amazon states that there can be only integer values and countries
      self.qualifier = {}
      if type.is_a?(String)
        qualifier[:QualificationTypeId] = type
      elsif type.is_a?(Symbol)
        qualifier[:QualificationTypeId] = Qualification.types[type]
      end

      if opts.is_a?(Hash)
        qualifier[:RequiredToPreview] = opts['RequiredToPreview'].to_s unless opts['RequiredToPreview'].nil?
        qualifier.merge!(build_comparator(opts))
      elsif opts == true || opts == false
        qualifier[:IntegerValue] = opts == true ? 1 : 0
        qualifier[:Comparator] = COMPARATORS[:eql]
      end

      qualifier
    end

    def to_params
      params = {}
      params["QualificationTypeId"] = qualifier[:QualificationTypeId]
      params["Comparator"] = qualifier[:Comparator]
      params["IntegerValue"] = qualifier[:IntegerValue] if qualifier[:IntegerValue]
      params["LocaleValue.Country"] = qualifier[:Country] if qualifier[:Country]
      params["RequiredToPreview"] = qualifier[:RequiredToPreview] || 'true'
      params
    end

    private

    def build_comparator(opts)
      qualifier = {}
      opts.each do |k,v|
        if COMPARATORS.has_key?(k)
          qualifier[:Comparator] = COMPARATORS[k]
          next if v.nil?  # to allow :exists => nil
          if v.to_s.match(/[A-Z]./)
            qualifier[:Country] = v
          else
            qualifier[:IntegerValue] = v unless k == :exists
          end
        end
      end
      qualifier
    end

  end

end
