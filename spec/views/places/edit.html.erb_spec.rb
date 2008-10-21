require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/places/edit.html.erb" do
  include PlacesHelper
  
  before(:each) do
    assigns[:place] = @place = stub_model(Place,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/places/edit.html.erb"
    
    response.should have_tag("form[action=#{place_path(@place)}][method=post]") do
    end
  end
end


