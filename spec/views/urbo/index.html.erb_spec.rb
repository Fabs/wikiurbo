require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/urbo/index.html.erb" do  
  
  before(:each) do
    assigns[:map] = @map = GMap.new("map_div")
    @map.center_zoom_init([0,0],1)    
  end
  
  it "should render the map" do
    assigns[:map] = @map = mock(GMap)
    @map.should_receive(:to_html)
    @map.should_receive(:div).and_return()
    @map.should_receive(:header_width_height)
    GMap.should_receive(:header)    
    render "/urbo/index.html.erb"
  end
  
  it "should render the links to access the authentication system" do
    render "/urbo/index.html.erb"
    response.should have_tag("a[href=?]","/signup","Signup")
    response.should have_tag("a[href=?]","/login","Login")
  end
  
end