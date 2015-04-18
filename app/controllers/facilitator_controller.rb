class FacilitatorController < ApplicationController
  def index
    #setting the instance course for the facilitator
    @course = Course.find(params[:course].to_i)

    #finding the user to add as facilitator
    if params[:search_field]
      @user = User.select{|user| user.email.downcase.include? params[:search_field].downcase}
    else
      @user = User.where('id not in (?)', @course.users)
    end
  end

  def create
    params.keys.each do |key|
      if key.include? "@" and params[key] == "1"
        course = Course.find(params[:course].to_i)
        user = User.find_by_email(key)
        user.update_attribute(:facilitator, true)
        CoursesUser.create!(user_id: user.id, course_id: course.id)
      end
    end
    redirect_to course_path(:id => params[:course])
  end

  def delete
    relation = CoursesUser.find_by_user_id_and_course_id(params[:user].to_i, params[:course].to_i)
    relation.destroy
    redirect_to course_path(:id => params[:course])
  end

  def facilitate_request
    course = Course.find(params[:course].to_i)
    FacilitateRequest.create!(request_id: current_user.id, receiver_id: course.id)
    redirect_to course_path(:id => params[:course])
  end

end
