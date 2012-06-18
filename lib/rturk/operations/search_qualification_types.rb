module RTurk
  class SearchQualificationTypes < Operation
    # You can call this operation without only required parameters and get an unsorted
    # list or you can pass in a :sort_by => {:name => :ascending}
    #
    # You can sort by
    #   :name
    
    attr_accessor :query, :sort_property, :sort_order, :page_size, :page_number, :sort_by, :must_be_requestable, :must_be_owned_by_caller
    require_params :must_be_requestable
    
    SORT_BY = { :name => 'Name' }
    SORT_ORDER = {:ascending => 'Ascending', :descending => 'Descending', :asc => 'Ascending', :desc => 'Descending'}
    
    def parse(xml)
      RTurk::SearchQualificationTypesResponse.new(xml)
    end
    
    def to_params
      self.set_sort_by
      params = {
        'Query' => self.query,
        'SortProperty' => self.sort_property,
        'SortDirection' => self.sort_order,
        'PageSize' => (self.page_size || 100),
        'PageNumber' => (self.page_number || 1)
      }
      params['MustBeRequestable'] = self.must_be_requestable unless self.must_be_requestable.nil?
      params['MustBeOwnedByCaller'] = self.must_be_owned_by_caller unless self.must_be_owned_by_caller.nil?
      params
    end
    
    def set_sort_by
      if @sort_by
        @sort_property = SORT_BY[@sort_by.keys.first]
        @sort_order = SORT_ORDER[@sort_by.values.first]
      end
    end
    
  end

  def self.SearchQualificationTypes(*args)
    RTurk::SearchQualificationTypes.create(*args)
  end

end