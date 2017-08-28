# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter { |c| Authorization.current_user = c.current_user }
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
def current_user
  if session[:current_user_id]!= nil
  @user=User.find(session[:current_user_id])
  if @user!=nil
    return @user
  end
  end
  end
    
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
