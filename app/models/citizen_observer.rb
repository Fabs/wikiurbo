class CitizenObserver < ActiveRecord::Observer
  def after_create(citizen)
    CitizenMailer.deliver_signup_notification(citizen)
  end

  def after_save(citizen)
  
    CitizenMailer.deliver_activation(citizen) if citizen.recently_activated?
  
  end
end
