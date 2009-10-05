module RTurk
  
  class Qualifications
    
    # For more information about qualification requirements see:
    # http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/index.html?ApiReference_QualificationRequirementDataStructureArticle.html
    #

    COMPARATORS = {:gt => 'GreaterThan', :lt => 'LessThan', :gte => 'GreaterThanOrEqualTo',
                   :lte => 'LessThanOrEqualTo', :eql => 'EqualTo', :not => 'NotEqualTo', :exists => 'Exists'}
                   
    TYPES = {:approval_rate => '000000000000000000L0', :submission_rate => '00000000000000000000',
             :abandoned_rate => '0000000000000000007', :return_rate => '000000000000000000E0',
             :rejection_rate => '000000000000000000S0', :hits_approved => '00000000000000000040',
             :adult => '00000000000000000060', :country => '00000000000000000071'}
    
    attr_accessor :requirements, :types
    
    def initialize
      @requirements = []
      @types = {}
    end
    
    
    # Builds the basic requirements for a qualification
    # needs at the minimum
    #  :type_id, :comparator => :value
    #
    def build (opts)
      # If the value is a string, we can assume it's the country since,
      # Amazon states that there can be only integer values and countries
      operation = opts.reject{|k,v| !COMPARATORS.include?(k)}
      comparator = COMPARATORS[operation.keys.first]
      value = operation.values.first
      params = {}
      value = 1 if value == true # For boolean types eg. Adult
      if value.to_s.match(/[A-Z]./)
        params[:Country] = value
      else
        params[:IntegerValue] = value
      end
      params = params.merge({:QualificationTypeId => opts[:type_id],
              :Comparator => comparator, :RequiredToPreview => opts[:required_to_preview]})
    end
  
    def to_aws_params
      params = {}
      @requirements.each_with_index do |qualifier, i|
        params["QualificationRequirement.#{i+1}.QualificationTypeId"] = qualifier[:QualificationTypeId]
        params["QualificationRequirement.#{i+1}.Comparator"] = qualifier[:Comparator]
        params["QualificationRequirement.#{i+1}.IntegerValue"] = qualifier[:IntegerValue] if qualifier[:IntegerValue]
        params["QualificationRequirement.#{i+1}.LocaleValue.Country"] = qualifier[:Country] if qualifier[:Country]
        params["QualificationRequirement.#{i+1}.RequiredToPreview"] = qualifier[:RequiredToPreview] || 'true'
      end
      params
    end
  
    # Can use this to manually add custom requirement types
    # Needs a type name(you can reference this later)
    # and the operation as a hash: ':gt => 85'
    # Example
    # qualifications.add('EnglishSkillsRequirement', :gt => 66, :type_id => '1234567890123456789ABC')
    #
    def add(opts)
      @requirements << self.build(opts)
    end
    
    # This lets you add a custom named type to the list
    # Example
    #   qualifications.add_type(:custom_requirement, '1234567890123456789ABC')
    #   qualifications.custom_requirement(:gte => 55)
    #
    def add_type(name, type_id)
      @types[name.to_sym] = type_id
    end
  
    def method_missing(method, opts)
      if opts == true || opts == false
        # allows us to call booleans on a method
        # e.g. qualifications.adult(true)
        opts = {:eql => opts}
      end
      if types.include?(method)
        opts.merge!({:type_id => types[method]})
        self.add(opts)
      end
    end
    
    def types
      TYPES.merge(@types)
    end
      
  end

    
end


