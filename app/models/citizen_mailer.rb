class CitizenMailer < ActionMailer::Base
  def signup_notification(citizen)
    setup_email(citizen)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{citizen.activation_code}"
  
  end
  
  def activation(citizen)
    setup_email(citizen)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(citizen)
      @recipients  = "#{citizen.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:citizen] = citizen
    end
end
