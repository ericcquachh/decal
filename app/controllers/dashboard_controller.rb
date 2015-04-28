class DashboardController < ApplicationController

  before_filter :logged_in

  def logged_in
    if current_user.nil? || !(user_signed_in?)
      redirect_to :root, notice: 'make sure you login fool'
    end
  end

  def index
  end

  def create
    params.keys.each do |key|
      if params[key] == "1"
       course = Course.find_by_title(key)
       relation = FacilitateOwnedcourse.find_by_facilitator_id_and_ownedcourse_id(current_user.id, course.id)
       relation.destroy 
      end
    end
    redirect_to dashboard_path
  end
end
