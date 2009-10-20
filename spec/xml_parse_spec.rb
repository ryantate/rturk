require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::XMLParse do
  
  before(:all) do
    @xml = <<-XML
    <foo>
      <bar>
        <baz>
          <fuck>content!!!</fuck>
        </baz>
      </bar>
    </foo>
    XML
    @xml = Nokogiri::XML(@xml)
  end
  
  it "should parse a answer" do
    RTurk::XMLParse(@xml).should eql({'foo' => { 'bar' => {'baz' => {'fuck' => 'content!!!'}}}})
  end

  
end