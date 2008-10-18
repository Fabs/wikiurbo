require File.dirname(__FILE__) + '/../helper'

RE_Citizen      = %r{(?:(?:the )? *(\w+) *)}
RE_Citizen_TYPE = %r{(?: *(\w+)? *)}
steps_for(:citizen) do

  #
  # Setting
  #
  
  Given "an anonymous citizen" do 
    log_out!
  end

  Given "$an $citizen_type citizen with $attributes" do |_, citizen_type, attributes|
    create_citizen! citizen_type, attributes.to_hash_from_story
  end
  
  Given "$an $citizen_type citizen named '$login'" do |_, citizen_type, login|
    create_citizen! citizen_type, named_citizen(login)
  end
  
  Given "$an $citizen_type citizen logged in as '$login'" do |_, citizen_type, login|
    create_citizen! citizen_type, named_citizen(login)
    log_in_citizen!
  end
  
  Given "$actor is logged in" do |_, login|
    log_in_citizen! @citizen_params || named_citizen(login)
  end
  
  Given "there is no $citizen_type citizen named '$login'" do |_, login|
    @citizen = Citizen.find_by_login(login)
    @citizen.destroy! if @citizen
    @citizen.should be_nil
  end
  
  #
  # Actions
  #
  When "$actor logs out" do 
    log_out
  end

  When "$actor registers an account as the preloaded '$login'" do |_, login|
    citizen = named_citizen(login)
    citizen['password_confirmation'] = citizen['password']
    create_citizen citizen
  end

  When "$actor registers an account with $attributes" do |_, attributes|
    create_citizen attributes.to_hash_from_story
  end
  
  When "$actor activates with activation code $attributes" do |_, activation_code|
    activation_code = '' if activation_code == 'that is blank'
    activate 
  end  

  When "$actor logs in with $attributes" do |_, attributes|
    log_in_citizen attributes.to_hash_from_story
  end
  
  #
  # Result
  #
  Then "$actor should be invited to sign in" do |_|
    response.should render_template('/sessions/new')
  end
  
  Then "$actor should not be logged in" do |_|
    controller.logged_in?.should_not be_true
  end
    
  Then "$login should be logged in" do |login|
    controller.logged_in?.should be_true
    controller.current_citizen.should === @citizen
    controller.current_citizen.login.should == login
  end
    
end

def named_citizen login
  citizen_params = {
    'admin'   => {'id' => 1, 'login' => 'addie', 'password' => '1234addie', 'email' => 'admin@example.com',       },
    'oona'    => {          'login' => 'oona',   'password' => '1234oona',  'email' => 'unactivated@example.com'},
    'reggie'  => {          'login' => 'reggie', 'password' => 'monkey',    'email' => 'registered@example.com' },
    }
  citizen_params[login.downcase]
end

#
# Citizen account actions.
#
# The ! methods are 'just get the job done'.  It's true, they do some testing of
# their own -- thus un-DRY'ing tests that do and should live in the citizen account
# stories -- but the repetition is ultimately important so that a faulty test setup
# fails early.  
#

def log_out 
  get '/sessions/destroy'
end

def log_out!
  log_out
  response.should redirect_to('/')
  follow_redirect!
end

def create_citizen(citizen_params={})
  @citizen_params       ||= citizen_params
  post "/citizens", :citizen => citizen_params
  @citizen = Citizen.find_by_login(citizen_params['login'])
end

def create_citizen!(citizen_type, citizen_params)
  citizen_params['password_confirmation'] ||= citizen_params['password'] ||= citizen_params['password']
  create_citizen citizen_params
  response.should redirect_to('/')
  follow_redirect!
 
  # fix the citizen's activation status
  activate_citizen! if citizen_type == 'activated'
end

 
def activate_citizen activation_code=nil
  activation_code = @citizen.activation_code if activation_code.nil?
  get "/activate/#{activation_code}"
end

def activate_citizen! *args
  activate_citizen *args
  response.should redirect_to('/login')
  follow_redirect!
  response.should have_flash("notice", /Signup complete!/)
end

def log_in_citizen citizen_params=nil
  @citizen_params ||= citizen_params
  citizen_params  ||= @citizen_params
  post "/session", citizen_params
  @citizen = Citizen.find_by_login(citizen_params['login'])
  controller.current_citizen
end

def log_in_citizen! *args
  log_in_citizen *args
  response.should redirect_to('/')
  follow_redirect!
  response.should have_flash("notice", /Logged in successfully/)
end
