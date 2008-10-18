require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/urbo/index.html.erb" do  
  
  it "should render the map" do
    assigns[:map] = @map = mock(GMap)
    @map.should_receive(:to_html)
    @map.should_receive(:div).and_return()
    @map.should_receive(:header_width_height)
    GMap.should_receive(:header)    
    render "/urbo/index.html.erb"
  end
  
end