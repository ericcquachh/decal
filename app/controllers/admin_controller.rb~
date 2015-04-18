class AdminController < ApplicationController
  def index
    filter = {}
    Course.filter_attributes.each do |attribute, values|
      if !params[attribute] || params[attribute] == 'Select'
        params.delete(attribute)
        filter[attribute] = values
      else 
        if attribute == :units
          params[attribute] = params[attribute].keys
        end
      filter[attribute] = params[attribute]
      end
    end

    @courses = Course.find(:all, :order => params[:title], :conditions => {:category => filter[:category], :status => filter[:status], 
    :units => filter[:units], :pending => params[:tab] == 'pending'})

    if params[:search_field]
      @courses = @courses.select {|course| course.title.downcase.include? params[:search_field].downcase}
    end

    if params[:section_time]
      params[:section_time] = Section_time.filter_section_time params[:section_time]
      if !params[:section_time].empty?
        @courses = @courses.select {|course| course.section_times.any? {|time| time.include_time? params[:section_time]}}
      else
        params.delete(:section_time)
      end
    end
  end

  def create
    params.keys.each do |key|
      if params[key] == "1"
        course = Course.find_by_title(key)
        if course.pending.eql? false
          course.pending = true
          course.save
        else
          course.pending = false
          #course.users.each do |user|
            #current_user.update_attribute :facilitator, true

          #end
          course.save

        end
      end
    end
    redirect_to "/admin"
  end
end
