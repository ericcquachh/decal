class ApplicationController < ActionController::Base

  protect_from_forgery

  def logged_in
    if current_user.nil? || !(user_signed_in?)
      redirect_to user_omniauth_authorize_path(:google_oauth2)
    end
  end

  def is_facilitator
    if !(Course.find(params[:course_id]).verify_facilitator? current_user)
      redirect_to :root, notice: 'You do not have these priveleges'
    end
  end

end
