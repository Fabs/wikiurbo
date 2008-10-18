module AuthenticatedTestHelper
  # Sets the current citizen in the session from the citizen fixtures.
  def login_as(citizen)
    @request.session[:citizen_id] = citizen ? citizens(citizen).id : nil
  end

  def authorize_as(citizen)
    @request.env["HTTP_AUTHORIZATION"] = citizen ? ActionController::HttpAuthentication::Basic.encode_credentials(citizens(citizen).login, 'monkey') : nil
  end
  
  # rspec
  def mock_citizen
    citizen = mock_model(Citizen, :id => 1,
      :login  => 'user_name',
      :name   => 'U. Surname',
      :to_xml => "Citizen-in-XML", :to_json => "Citizen-in-JSON", 
      :errors => [])
    citizen
  end  
end
