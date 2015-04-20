class FacilitatorController < ApplicationController

  before_filter :is_facilitator, :except => [:facilitator_request]
  before_filter :logged_in, :only => [:facilitator_request]

  def is_facilitator
    if !(Course.find(params[:course_id]).verify_facilitator? current_user)
      redirect_to :root, notice: 'You do not have access to this page'
    end
  end

  def logged_in
    if current_user.nil? || !(user_signed_in?)
      redirect_to :root, notice: 'make sure you login fool'
    end
  end

  def index
    @course = Course.find(params[:course_id])
    @users = User.where('id NOT IN (?)', @course.facilitators.empty? ? '' : @course.facilitators)
    if params[:search_field]
      @users = @users.select{|user| user.email.downcase.include? params[:search_field].downcase}
    end
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

  def facilitator_request
    FacilitateRequest.create!(request_id: current_user.id, receiver_id: params[:course_id])
    redirect_to course_path(:id => params[:course_id])
  end

end
