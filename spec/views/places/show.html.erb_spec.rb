require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/places/show.html.erb" do
  include PlacesHelper
  
  before(:each) do
    assigns[:place] = @place = stub_model(Place)
  end

  it "should render attributes in <p>" do
    render "/places/show.html.erb"
  end
  
  it "should allow to create a subplace" do
    render '/places/show.html.erb'
    response.should have_tag("a[href=?]", new_place_path) do
    end
  end
  
end

