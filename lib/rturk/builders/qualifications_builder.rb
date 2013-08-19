module RTurk

  class Qualifications

    # For more information about qualification requirements see:
    # http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/index.html?ApiReference_QualificationRequirementDataStructureArticle.html
    #

    def to_params
      params = {}
      qualifications.each_with_index do |qualification, i|
        qualification.to_params.each_pair do |k,v|
          params["QualificationRequirement.#{i+1}.#{k}"] = v
        end
      end
      params
    end

    # Can use this to manually add custom requirement types
    # Needs a type name(you can reference this later)
    # and the operation as a hash: ':gt => 85'
    # Example
    # qualifications.add('EnglishSkillsRequirement', :gt => 66, :type_id => '1234567890123456789ABC')
    #
    def add(type, opts)
      qualifications << RTurk::Qualification.new(type, opts)
    end
    
    def qualifications
      @qualifications ||= []
    end


    def method_missing(method, *args)
      if RTurk::Qualification.types.include?(method)
        self.add(method, *args)
      else
        super
      end
    end

  end


end
