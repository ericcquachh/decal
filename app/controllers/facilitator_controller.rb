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
        FacilitateOwnedcourses.create!(facilitator_id: user.id, ownedcourse_id: course.id)
        FacilitateRequests.destroy_all(request_id: user_id, receiver_id: course.id)
      end
    end
    redirect_to course_path(:id => params[:course])
  end

  def delete
    relation = FacilitateOwnedcourses.find_by_facilitator_id_and_ownedcourse_id(params[:user].to_i, params[:course].to_i)
    relation.destroy
    redirect_to course_path(:id => params[:course])
  end

  def request
    course = Course.find(params[:course].to_i)
    FacilitateRequests.create!(request_id: current_user.id, receiver_id: course.id)
    redirect_to course_path(:id => params[:course])
  end
    

end
