require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/citizens/new.html.erb" do
  include CitizensHelper
  
  before(:each) do
    assigns[:citizen] = stub_model(Citizen,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/citizens/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", citizens_path) do
    end
  end
end


