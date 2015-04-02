class SectionsController < ApplicationController
	def new
		@course = Course.find(params[:course_id])
		@section = Section.new
	end

	def create
		filter_time()
	    @section = Section.new(params[:section])
	    @section.course = Course.find(params[:course_id])
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

	def filter_time
		params[:section][:start_time] = Time.parse(params[:section]['start_time(4i)'] + ':' + params[:section]['start_time(5i)']).strftime("%I:%M%p")
		params[:section][:end_time] = Time.parse(params[:section]['end_time(4i)'] + ':' + params[:section]['end_time(5i)']).strftime("%I:%M%p")
		params[:section].delete 'start_time(4i)'
		params[:section].delete 'start_time(5i)'
		params[:section].delete 'end_time(4i)'
		params[:section].delete 'end_time(5i)'
	end
end
