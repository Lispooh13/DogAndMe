module NotificationsHelper
  def unchecked_notifications
    
    @notifications = current_user.passive_notifications.where(checked: false) if user_signed_in? 
    
  end
end
