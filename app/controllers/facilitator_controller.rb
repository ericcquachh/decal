class FacilitatorController < ApplicationController

  before_filter :is_facilitator

  def index
    @course = Course.find(params[:course_id])
    @users = User.where('id NOT IN (?)', @course.facilitators.empty? ? '' : @course.facilitators).order(:email)
    @users = @users.where('email ILIKE ?', "%#{params[:search_field]}%") if !params[:search_field].blank?
  end

  def create
    userid = params[:user_id]
    courseid = params[:course_id]
    FacilitateOwnedcourse.create!(facilitator_id: userid, ownedcourse_id: courseid)
    FacilitateRequest.destroy_all(request_id: userid, receiver_id: courseid)
    if params[:page] == 'manual'
      redirect_to course_facilitator_index_path(:course_id => courseid), :method => :get, notice: "User has been promoted to facilitator"
    else
      redirect_to course_path(:id => courseid), notice: "User has been promoted to facilitator"
    end
  end

  def delete
    userid = params[:user_id]
    courseid = params[:course_id]
    FacilitateOwnedcourse.destroy_all(facilitator_id: userid, ownedcourse_id: courseid)
    FacilitateRequest.destroy_all(request_id: userid, receiver_id: courseid)
    if params[:page] == 'dashboard'
      redirect_to dashboard_index_path
    else
      redirect_to course_path(:id => courseid)
    end
  end

end
