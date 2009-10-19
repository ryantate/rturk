module RTurk

  class Qualification

    # For more information about qualification requirements see:
    # http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/index.html?ApiReference_QualificationRequirementDataStructureArticle.html
    #

    COMPARATORS = {:gt => 'GreaterThan', :lt => 'LessThan', :gte => 'GreaterThanOrEqualTo',
                   :lte => 'LessThanOrEqualTo', :eql => 'EqualTo', :not => 'NotEqualTo', :exists => 'Exists'}

    TYPES = {:approval_rate => '000000000000000000L0', :submission_rate => '00000000000000000000',
             :abandoned_rate => '0000000000000000007', :return_rate => '000000000000000000E0',
             :rejection_rate => '000000000000000000S0', :hits_approved => '00000000000000000040',
             :adult => '00000000000000000060', :country => '00000000000000000071'}

    attr_accessor :qualifier

    # Builds the basic requirements for a qualification
    # needs at the minimum
    #  type_id, :comparator => :value
    #  or
    #  type_id, true
    #  or
    #  type_id, :exists
    #
    def initialize(type, opts)
      # If the value is a string, we can assume it's the country since,
      # Amazon states that there can be only integer values and countries
      self.qualifier = {}
      if type.is_a?(String)
        qualifier[:QualificationTypeId] = type
      elsif type.is_a?(Symbol)
        qualifier[:QualificationTypeId] = types[type]
      end
      if opts.is_a?(Hash)
        qualifier[:Comparator] = COMPARATORS[opts.keys.first]
        value = opts.values.first
        if value.to_s.match(/[A-Z]./)
          qualifier[:Country] = value
        else
          qualifier[:IntegerValue] = value
        end
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

    def types
      # Could use this later to add other TYPES programatically
      TYPES
    end

  end

end
