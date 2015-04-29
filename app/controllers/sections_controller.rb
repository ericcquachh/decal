class SectionsController < ApplicationController

  before_filter :can_edit

  def can_edit
    if !(Course.find(params[:course_id]).verify_facilitator? current_user)
      redirect_to course_path(params[:course_id]), notice: 'You do not have access to this page'
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @section = Section.new
  end

  def create
    Section.to_add! params[:section]
    @section = Section.new(params[:section])
    @course = Course.find(params[:course_id])
    if @section.valid?
      @section.course = @course
      @section.save!
      redirect_to course_path(params[:course_id]), notice: 'You have successfully created the section'
    else
      render 'new'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to course_path(params[:course_id]), :notice => "Section successfully deleted"
  end

  def edit
    @section = Section.find(params[:id])
  end


end
