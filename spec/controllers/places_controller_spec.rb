require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlacesController do

  def mock_place(stubs={})
    @mock_place ||= mock_model(Place, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all places as @places" do
      Place.should_receive(:find).with(:all).and_return([mock_place])
      get :index
      assigns[:places].should == [mock_place]
    end

    describe "with mime type of xml" do
  
      it "should render all places as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Place.should_receive(:find).with(:all).and_return(places = mock("Array of Places"))
        places.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested place as @place" do
      Place.should_receive(:find).with("37").and_return(mock_place)
      get :show, :id => "37"
      assigns[:place].should equal(mock_place)
    end
    
    describe "with mime type of xml" do

      it "should render the requested place as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Place.should_receive(:find).with("37").and_return(mock_place)
        mock_place.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new place as @place if citizen is logged in" do
      controller.should_receive(:logged_in?).and_return(true)
      Place.should_receive(:new).and_return(mock_place)
      get :new
      assigns[:place].should equal(mock_place)
    end
    
    it "should redirect to login page if citizen is not logged in" do
      controller.should_receive(:logged_in?).and_return(false)
      get :new
      response.should redirect_to("/login")
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested place as @place" do
      Place.should_receive(:find).with("37").and_return(mock_place)
      get :edit, :id => "37"
      assigns[:place].should equal(mock_place)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created place as @place" do
        Place.should_receive(:new).with({'these' => 'params'}).and_return(mock_place(:save => true))
        post :create, :place => {:these => 'params'}
        assigns(:place).should equal(mock_place)
      end

      it "should redirect to the created place" do
        Place.stub!(:new).and_return(mock_place(:save => true))
        post :create, :place => {}
        response.should redirect_to(place_url(mock_place))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved place as @place" do
        Place.stub!(:new).with({'these' => 'params'}).and_return(mock_place(:save => false))
        post :create, :place => {:these => 'params'}
        assigns(:place).should equal(mock_place)
      end

      it "should re-render the 'new' template" do
        Place.stub!(:new).and_return(mock_place(:save => false))
        post :create, :place => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested place" do
        Place.should_receive(:find).with("37").and_return(mock_place)
        mock_place.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :place => {:these => 'params'}
      end

      it "should expose the requested place as @place" do
        Place.stub!(:find).and_return(mock_place(:update_attributes => true))
        put :update, :id => "1"
        assigns(:place).should equal(mock_place)
      end

      it "should redirect to the place" do
        Place.stub!(:find).and_return(mock_place(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(place_url(mock_place))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested place" do
        Place.should_receive(:find).with("37").and_return(mock_place)
        mock_place.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :place => {:these => 'params'}
      end

      it "should expose the place as @place" do
        Place.stub!(:find).and_return(mock_place(:update_attributes => false))
        put :update, :id => "1"
        assigns(:place).should equal(mock_place)
      end

      it "should re-render the 'edit' template" do
        Place.stub!(:find).and_return(mock_place(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested place" do
      Place.should_receive(:find).with("37").and_return(mock_place)
      mock_place.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the places list" do
      Place.stub!(:find).and_return(mock_place(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(places_url)
    end

  end

end
