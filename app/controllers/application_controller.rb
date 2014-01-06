class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_user!(*args)
    if !current_user and request.xhr?
      flash.now[:alert] = 'Error'
      render :js => "window.location = '#{new_user_session_path}'"
    else
      super(*args)
    end
  end
end
