require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CitizensController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "citizens", :action => "index").should == "/citizens"
    end
  
    it "should map #show" do
      route_for(:controller => "citizens", :action => "show", :id => 1).should == "/citizens/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "citizens", :action => "edit", :id => 1).should == "/citizens/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "citizens", :action => "update", :id => 1).should == "/citizens/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "citizens", :action => "destroy", :id => 1).should == "/citizens/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/citizens").should == {:controller => "citizens", :action => "index"}
    end
    
    it "should generate params for #create" do
      params_from(:post, "/citizens").should == {:controller => "citizens", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/citizens/1").should == {:controller => "citizens", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/citizens/1/edit").should == {:controller => "citizens", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/citizens/1").should == {:controller => "citizens", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/citizens/1").should == {:controller => "citizens", :action => "destroy", :id => "1"}
    end
  end
end
