require File.dirname(__FILE__) + '/../spec_helper'
  
describe CitizensController do
  fixtures :citizens

  it 'allows signup' do
    lambda do
      create_citizen
      response.should be_redirect
    end.should change(Citizen, :count).by(1)
  end

  it 'signs up user with activation code' do
    create_citizen
    assigns(:citizen).reload
    assigns(:citizen).activation_code.should_not be_nil
  end
  it 'requires login on signup' do
    lambda do
      create_citizen(:login => nil)
      assigns[:citizen].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Citizen, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_citizen(:password => nil)
      assigns[:citizen].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Citizen, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_citizen(:password_confirmation => nil)
      assigns[:citizen].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Citizen, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_citizen(:email => nil)
      assigns[:citizen].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Citizen, :count)
  end
  
  
  it 'activates user' do
    Citizen.authenticate('aaron', 'monkey').should be_nil
    get :activate, :activation_code => citizens(:aaron).activation_code
    response.should redirect_to('/login')
    flash[:notice].should_not be_nil
    flash[:error ].should     be_nil
    Citizen.authenticate('aaron', 'monkey').should == citizens(:aaron)
  end
  
  it 'does not activate user without key' do
    get :activate
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with blank key' do
    get :activate, :activation_code => ''
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with bogus key' do
    get :activate, :activation_code => 'i_haxxor_joo'
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  def create_citizen(options = {})
    post :create, :citizen => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
end

describe CitizensController do
  describe "route generation" do
    it "should route citizens's 'index' action correctly" do
      route_for(:controller => 'citizens', :action => 'index').should == "/citizens"
    end
    
    it "should route citizens's 'new' action correctly" do
      route_for(:controller => 'citizens', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => 'citizens', :action => 'create'} correctly" do
      route_for(:controller => 'citizens', :action => 'create').should == "/register"
    end
    
    it "should route citizens's 'show' action correctly" do
      route_for(:controller => 'citizens', :action => 'show', :id => '1').should == "/citizens/1"
    end
    
    it "should route citizens's 'edit' action correctly" do
      route_for(:controller => 'citizens', :action => 'edit', :id => '1').should == "/citizens/1/edit"
    end
    
    it "should route citizens's 'update' action correctly" do
      route_for(:controller => 'citizens', :action => 'update', :id => '1').should == "/citizens/1"
    end
    
    it "should route citizens's 'destroy' action correctly" do
      route_for(:controller => 'citizens', :action => 'destroy', :id => '1').should == "/citizens/1"
    end
  end
  
  describe "route recognition" do
    it "should generate params for citizens's index action from GET /citizens" do
      params_from(:get, '/citizens').should == {:controller => 'citizens', :action => 'index'}
      params_from(:get, '/citizens.xml').should == {:controller => 'citizens', :action => 'index', :format => 'xml'}
      params_from(:get, '/citizens.json').should == {:controller => 'citizens', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for citizens's new action from GET /citizens" do
      params_from(:get, '/citizens/new').should == {:controller => 'citizens', :action => 'new'}
      params_from(:get, '/citizens/new.xml').should == {:controller => 'citizens', :action => 'new', :format => 'xml'}
      params_from(:get, '/citizens/new.json').should == {:controller => 'citizens', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for citizens's create action from POST /citizens" do
      params_from(:post, '/citizens').should == {:controller => 'citizens', :action => 'create'}
      params_from(:post, '/citizens.xml').should == {:controller => 'citizens', :action => 'create', :format => 'xml'}
      params_from(:post, '/citizens.json').should == {:controller => 'citizens', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for citizens's show action from GET /citizens/1" do
      params_from(:get , '/citizens/1').should == {:controller => 'citizens', :action => 'show', :id => '1'}
      params_from(:get , '/citizens/1.xml').should == {:controller => 'citizens', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/citizens/1.json').should == {:controller => 'citizens', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for citizens's edit action from GET /citizens/1/edit" do
      params_from(:get , '/citizens/1/edit').should == {:controller => 'citizens', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => 'citizens', :action => update', :id => '1'} from PUT /citizens/1" do
      params_from(:put , '/citizens/1').should == {:controller => 'citizens', :action => 'update', :id => '1'}
      params_from(:put , '/citizens/1.xml').should == {:controller => 'citizens', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/citizens/1.json').should == {:controller => 'citizens', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for citizens's destroy action from DELETE /citizens/1" do
      params_from(:delete, '/citizens/1').should == {:controller => 'citizens', :action => 'destroy', :id => '1'}
      params_from(:delete, '/citizens/1.xml').should == {:controller => 'citizens', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/citizens/1.json').should == {:controller => 'citizens', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route citizens_path() to /citizens" do
      citizens_path().should == "/citizens"
      formatted_citizens_path(:format => 'xml').should == "/citizens.xml"
      formatted_citizens_path(:format => 'json').should == "/citizens.json"
    end
    
    it "should route new_citizen_path() to /citizens/new" do
      new_citizen_path().should == "/citizens/new"
      formatted_new_citizen_path(:format => 'xml').should == "/citizens/new.xml"
      formatted_new_citizen_path(:format => 'json').should == "/citizens/new.json"
    end
    
    it "should route citizen_(:id => '1') to /citizens/1" do
      citizen_path(:id => '1').should == "/citizens/1"
      formatted_citizen_path(:id => '1', :format => 'xml').should == "/citizens/1.xml"
      formatted_citizen_path(:id => '1', :format => 'json').should == "/citizens/1.json"
    end
    
    it "should route edit_citizen_path(:id => '1') to /citizens/1/edit" do
      edit_citizen_path(:id => '1').should == "/citizens/1/edit"
    end
  end
  
end
