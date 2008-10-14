require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/citizens/edit.html.erb" do
  include CitizensHelper
  
  before(:each) do
    assigns[:citizen] = @citizen = stub_model(Citizen,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/citizens/edit.html.erb"
    
    response.should have_tag("form[action=#{citizen_path(@citizen)}][method=post]") do
    end
  end
end


