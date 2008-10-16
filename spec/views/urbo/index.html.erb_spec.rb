require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/urbo/index.html.erb" do  
  it "should render the map" do
    render "/urbo/index.html.erb"
    response.should have_tag('div#map_div')
    response.should have_tag('script[src=?][type=?]', '/javascripts/ym4r-gm.js', 'text/javascript')
  end
end