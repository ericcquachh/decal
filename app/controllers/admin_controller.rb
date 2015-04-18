class AdminController < ApplicationController

  def index
    sort = {}
    Course.sort_attributes.each do |attribute, values|
      if !params[attribute] || params[attribute] == 'Select'
        params.delete(attribute)
        sort[attribute] = values
      else 
        if attribute == :units
          params[attribute] = params[attribute].keys
        end
      sort[attribute] = params[attribute]
      end
    end

    @courses = Course.find(:all, :order => params[:title], :conditions => {:category => sort[:category], :status => sort[:status], 
    :units => sort[:units], :pending => false})

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
    if !params.has_key?(:tab)
      if session.has_key?(:tab)
        params[:tab] = session[:tab]
      else
        params[:tab] = 'curr'
      end

    end

    if params[:tab] == 'curr'
        @courses = Course.find(:all, :order => session[:title], :conditions => {:pending => false})
      elsif params[:tab] == 'pending'
        @courses = Course.find(:all, :order => session[:title], :conditions => {:pending => true})
      else
        #facilitators
      end
      session[:tab] = params[:tab]

      # @courses = Course.find(:all, :order => session[:title])

      if params[:search_field]
        @courses = @courses.select {|course| course.title.downcase.include? params[:search_field].downcase}
      end
      if params[:section_time]
        params[:section_time] = Section_time.filter_section_time params[:section_time]
        @courses = @courses.select {|course| course.section_times.any? {|time| time.include_time? params[:section_time]}}
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
