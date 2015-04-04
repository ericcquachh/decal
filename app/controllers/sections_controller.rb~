class SectionsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])
    @section.course = Course.find(params[:course_id])
    @section.section_time = Section_time.create(Section_time.filter_time_and_date(params[:section_time]))
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
