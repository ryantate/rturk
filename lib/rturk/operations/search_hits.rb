module RTurk
  class SearchHITs < Operation
    # You can call this operation without any parameters and get an unsorted
    # list or you can pass in a :sort_by => {:title => :ascending}
    #
    # You can sort by
    #   :title
    #   :reward
    #   :expiration
    #   :created_at
    #   :enumeration
    
    attr_accessor :sort_property, :sort_order, :page_size, :page_number, :sort_by
    
    SORT_BY = { :title => 'Title', :reward => 'Reward', :expiration => 'Expiration', :created_at => 'CreationTime', :enumeration => 'Enumeration'}
    SORT_ORDER = {:ascending => 'Ascending', :descending => 'Descending', :asc => 'Ascending', :desc => 'Descending'}
    
    def parse(xml)
      RTurk::SearchHITsResponse.new(xml)
    end
    
    def to_params
      self.set_sort_by
      {
        'SortProperty' => self.sort_property,
        'SortDirection' => self.sort_order,
        'PageSize' => (self.page_size || 100),
        'PageNumber' => (self.page_number || 1)
      }
    end
    
    def set_sort_by
      if @sort_by
        @sort_property = SORT_BY[@sort_by.keys.first]
        @sort_order = SORT_ORDER[@sort_by.values.first]
      end
    end
    
  end
  def self.SearchHITs
    RTurk::SearchHITs.create
  end

end