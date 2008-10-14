require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UrboController do
  describe "route generation" do

    it "should map #index" do
      route_for(:controller => "urbo", :action => "index").should == "/"
    end
  end

  describe "route recognition" do

    it "should generate params for #index" do
      params_from(:get, "/").should == {:controller => "urbo", :action => "index"}
    end
  end
end
