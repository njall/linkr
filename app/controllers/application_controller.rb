class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    links_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, :notice => 'You must be logged in to see this page'
    end
  end

end
