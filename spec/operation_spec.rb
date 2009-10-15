require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Operation do
  
  before(:all) do
    class Mark < RTurk::Operation
      
      def is_awesome?
        true
      end
      RTurk::Operation.register('mark', self)
    end
    
  end
  
  it "should build a question" do
    p RTurk::Operation.defined_operations
    RTurk::Operation.defined_operations.include?('mark').should be_true
  end
  
end