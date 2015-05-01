class DashboardController < ApplicationController

  before_filter :logged_in

  def logged_in
    if current_user.nil? || !(user_signed_in?)
      redirect_to :root, notice: 'make sure you login fool'
    end
  end

  def index
  end

end
