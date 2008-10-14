require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/citizens/index.html.erb" do
  include CitizensHelper
  
  before(:each) do
    assigns[:citizens] = [
      stub_model(Citizen),
      stub_model(Citizen)
    ]
  end

  it "should render list of citizens" do
    render "/citizens/index.html.erb"
  end
end

