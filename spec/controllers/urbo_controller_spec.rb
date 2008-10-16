require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrboController do
  describe "requesting / with get" do
    
    it "should render urbo/view" do
      get :index
      response.should render_template("index")
    end
  end
end
