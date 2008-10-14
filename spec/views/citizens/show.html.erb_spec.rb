require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/citizens/show.html.erb" do
  include CitizensHelper
  
  before(:each) do
    assigns[:citizen] = @citizen = stub_model(Citizen)
  end

  it "should render attributes in <p>" do
    render "/citizens/show.html.erb"
  end
end

