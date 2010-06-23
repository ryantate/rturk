require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::Notification do
  before(:each) do
    @notification = RTurk::Notification.new
  end

  it "should not allow extra parameters" do
    lambda {
      @notification[:Bananas]
    }.should raise_error NameError
  end

  describe "#to_param_hash" do
    it "should not allow for empty params" do
      lambda {
        @notification.to_param_hash
      }.should raise_error RTurk::MissingParameters
    end

    it "should return a REST-friendly hash" do
      @notification.destination = 'foo'
      @notification.transport = 'bar'
      @notification.event_type = 'mumble'

      @notification.to_param_hash.should ==
        { "Notification.1.Destination" => 'foo',
          "Notification.1.Transport" => 'bar',
          "Notification.1.Version" => RTurk::OLD_API_VERSION,
          "Notification.1.EventType" => 'mumble' }
    end
    
    it "should allow multiple event types" do
      @notification.destination = 'foo'
      @notification.transport = 'bar'
      @notification.event_type = ['mumble', 'bumble']
      @notification.to_param_hash.should ==
        { "Notification.1.Destination" => 'foo',
          "Notification.1.Transport" => 'bar',
          "Notification.1.Version" => RTurk::OLD_API_VERSION,
          "Notification.1.EventType.1" => 'mumble',
          "Notification.1.EventType.2" => 'bumble' }
    end
  end
end
