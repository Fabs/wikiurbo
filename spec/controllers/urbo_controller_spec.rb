require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrboController do
  
  def mock_map(stubs={})
    @mock_map ||= mock_model(GMap, stubs)
  end
  
  describe "requesting / with get" do
    
    it "should render urbo/view" do
      get :index
      response.should render_template("index")
    end

    it "should expose the map as @map" do
      GMap.should_receive(:new).with("map_div").and_return(mock_map)
      mock_map.should_receive(:center_zoom_init).with([0, 0], 1)
      get :index
      assigns[:map].should == mock_map
    end
    
  end
  
end
