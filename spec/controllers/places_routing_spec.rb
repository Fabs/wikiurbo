require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlacesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "places", :action => "index").should == "/places"
    end
  
    it "should map #new" do
      route_for(:controller => "places", :action => "new").should == "/places/new"
    end
  
    it "should map #show" do
      route_for(:controller => "places", :action => "show", :id => 1).should == "/places/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "places", :action => "edit", :id => 1).should == "/places/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "places", :action => "update", :id => 1).should == "/places/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "places", :action => "destroy", :id => 1).should == "/places/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/places").should == {:controller => "places", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/places/new").should == {:controller => "places", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/places").should == {:controller => "places", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/places/1").should == {:controller => "places", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/places/1/edit").should == {:controller => "places", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/places/1").should == {:controller => "places", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/places/1").should == {:controller => "places", :action => "destroy", :id => "1"}
    end
  end
end
