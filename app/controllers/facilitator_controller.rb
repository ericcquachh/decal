class FacilitatorController < ApplicationController
  def index
    @course = Course.find(params[:course])
    @user = User.where('id not in (?)', @course.facilitators)
    if params[:search_field]
      @user = @user.select{|user| user.email.downcase.include? params[:search_field].downcase}
    end
  end

  def create
    params.keys.each do |key|
      if key.include? "@" and params[key] == "1"
        course = Course.find(params[:course].to_i)
        user = User.find_by_email(key)
        FacilitateOwnedcourse.create!(facilitator_id: user.id, ownedcourse_id: course.id)
        FacilitateRequest.destroy_all(request_id: user.id, receiver_id: course.id)
      end
    end
    redirect_to course_path(:id => params[:course])
  end

  def delete
    relation = FacilitateOwnedcourse.find_by_facilitator_id_and_ownedcourse_id(params[:user].to_i, params[:course].to_i)
    relation.destroy
    redirect_to course_path(:id => params[:course])
  end

  def facilitator_request
    course = Course.find(params[:course].to_i)
    FacilitateRequest.create!(request_id: current_user.id, receiver_id: course.id)
    redirect_to course_path(:id => params[:course])
  end


end
