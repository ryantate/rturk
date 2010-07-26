# Operation to despose a qualification type

module RTurk
  class DisposeQualificationType < Operation
    attr_accessor :name, :description, :keywords, :status
    require_params :name

    def to_params
      {'Name' => name,
       'Description' => description,
       'Keywords' => keywords,
       'QualificationTypeStatus' => (status || "Active")}
    end
  end

  def self.DisposeQualificationType(*args)
    RTurk::DisposeQualificationType.create(*args)
  end
end