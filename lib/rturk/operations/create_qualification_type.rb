# Operation to create a qualification type

module RTurk
  class CreateQualificationType < Operation
    attr_accessor :name, :description, :keywords, :status, :is_requestable, :auto_granted
    require_params :name

    def to_params
      {'Name' => name,
       'Description' => description,
       'Keywords' => keywords,
       'QualificationTypeStatus' => (status || "Active"),
       'IsRequestable' => (!!is_requestable).to_s,
       'AutoGranted' => (auto_granted.nil? ? true : auto_granted).to_s}
    end
  end

  def self.CreateQualificationType(*args)
    RTurk::CreateQualificationType.create(*args)
  end
end