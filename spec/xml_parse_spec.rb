require 'spec_helper'


describe RTurk::XMLUtilities do
  
  before(:all) do
    class XMLTest
      include RTurk::XMLUtilities
      def xml
      <<-XML
      <foo>
        <bar>
          <baz>
            <fuck>content!!!</fuck>
          </baz>
        </bar>
      </foo>
      XML
      end
      def parse
        xml_to_hash(Nokogiri::XML(xml))
      end
    end
  end
  
  it "should parse a answer" do
    
    XMLTest.new.parse.should eql({'foo' => { 'bar' => {'baz' => {'fuck' => 'content!!!'}}}})
  end

  
end