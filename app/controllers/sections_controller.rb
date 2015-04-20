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
    @section = Section.new(params[:section])
    @section.course = Course.find(params[:course_id])
    params[:section_time] = Section_time.filter_section_time(params[:section_time])
    @section.section_time = Section_time.create(params[:section_time])
    
    @section.save!
    redirect_to course_path(params[:course_id]), :notice => params
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
