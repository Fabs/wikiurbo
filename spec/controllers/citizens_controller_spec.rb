require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CitizensController do

  def mock_citizen(stubs={})
    @mock_citizen ||= mock_model(Citizen, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all citizens as @citizens" do
      Citizen.should_receive(:find).with(:all).and_return([mock_citizen])
      get :index
      assigns[:citizens].should == [mock_citizen]
    end

    describe "with mime type of xml" do
  
      it "should render all citizens as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Citizen.should_receive(:find).with(:all).and_return(citizens = mock("Array of Citizens"))
        citizens.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested citizen as @citizen" do
      Citizen.should_receive(:find).with("37").and_return(mock_citizen)
      get :show, :id => "37"
      assigns[:citizen].should equal(mock_citizen)
    end
    
    describe "with mime type of xml" do

      it "should render the requested citizen as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Citizen.should_receive(:find).with("37").and_return(mock_citizen)
        mock_citizen.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new citizen as @citizen" do
      Citizen.should_receive(:new).and_return(mock_citizen)
      get :new
      assigns[:citizen].should equal(mock_citizen)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested citizen as @citizen" do
      Citizen.should_receive(:find).with("37").and_return(mock_citizen)
      get :edit, :id => "37"
      assigns[:citizen].should equal(mock_citizen)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created citizen as @citizen" do
        Citizen.should_receive(:new).with({'these' => 'params'}).and_return(mock_citizen(:save => true))
        post :create, :citizen => {:these => 'params'}
        assigns(:citizen).should equal(mock_citizen)
      end

      it "should redirect to the created citizen" do
        Citizen.stub!(:new).and_return(mock_citizen(:save => true))
        post :create, :citizen => {}
        response.should redirect_to(citizen_url(mock_citizen))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved citizen as @citizen" do
        Citizen.stub!(:new).with({'these' => 'params'}).and_return(mock_citizen(:save => false))
        post :create, :citizen => {:these => 'params'}
        assigns(:citizen).should equal(mock_citizen)
      end

      it "should re-render the 'new' template" do
        Citizen.stub!(:new).and_return(mock_citizen(:save => false))
        post :create, :citizen => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested citizen" do
        Citizen.should_receive(:find).with("37").and_return(mock_citizen)
        mock_citizen.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :citizen => {:these => 'params'}
      end

      it "should expose the requested citizen as @citizen" do
        Citizen.stub!(:find).and_return(mock_citizen(:update_attributes => true))
        put :update, :id => "1"
        assigns(:citizen).should equal(mock_citizen)
      end

      it "should redirect to the citizen" do
        Citizen.stub!(:find).and_return(mock_citizen(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(citizen_url(mock_citizen))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested citizen" do
        Citizen.should_receive(:find).with("37").and_return(mock_citizen)
        mock_citizen.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :citizen => {:these => 'params'}
      end

      it "should expose the citizen as @citizen" do
        Citizen.stub!(:find).and_return(mock_citizen(:update_attributes => false))
        put :update, :id => "1"
        assigns(:citizen).should equal(mock_citizen)
      end

      it "should re-render the 'edit' template" do
        Citizen.stub!(:find).and_return(mock_citizen(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested citizen" do
      Citizen.should_receive(:find).with("37").and_return(mock_citizen)
      mock_citizen.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the citizens list" do
      Citizen.stub!(:find).and_return(mock_citizen(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(citizens_url)
    end

  end

end
