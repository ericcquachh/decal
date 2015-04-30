class AdminController < ApplicationController

  before_filter :is_admin

  def is_admin
    if !current_user || !current_user.admin?
      redirect_to :root, notice: 'You do not have admin priveleges'
    end
  end


  def index
    params[:tab] ||= 'curr'
    if params[:tab] != 'manageadmins'
      @courses = Course.filter params, (params[:tab] == 'pending')
    else
      @users = User.joins(:facilitate_ownedcourses)
    end
  end

  def create
    if params[:course_ids]
      params[:course_ids] = params[:course_ids].keys
      params[:course_ids].each do |id|
        course = Course.find(id)
        if course.pending
          course.pending = false
          course.save!
        else
          course.pending = true
          course.save!
        end
      end
    end
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end

  def add_semester
    Semester.create(:name => params[:semester])
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end

  def add_category
    Category.create(:name => params[:category])
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end

  def remove_semester
    semester = Semester.find_by_name(params[:semester])
    semester.destroy
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end

  def remove_category
    category = Category.find_by_name(params[:category])
    category.destroy
    redirect_to admin_index_path(:tab => params[:tab]), method: :get
  end

end
