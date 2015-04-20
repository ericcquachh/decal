class AdminController < ApplicationController

  before_filter :is_admin

  def is_admin
    if !current_user || !current_user.admin?
      redirect_to :root, notice: 'You do not have admin priveleges'
    end
  end


  def index
    if !params[:tab]
      params[:tab] = 'curr'
    end
    if params[:tab] != 'manageadmins'
      @courses = Course.filter! params, params[:tab] == 'pending'
    else
      @users = User.joins(:facilitate_ownedcourses)
    end
  end

  def create
    params.keys.each do |key|
      if params[key] == "1"
        course = Course.find_by_title(key)
        if course.pending.eql? false
          course.pending = true
          course.save
        else
          course.pending = false
          #course.users.each do |user|
            #current_user.update_attribute :facilitator, true

          #end
          course.save

        end
      end
    end
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end
end
