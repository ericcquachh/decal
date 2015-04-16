class AdminController < ApplicationController

	def index
		#@courses = Course.find(:all, :conditions => {:pending => false})
		@all = Course.all_attributes
	    @attributes = @all.keys
	    @attributes.each {|attribute| session[attribute] = @all[attribute]}
	    @attributes.each do |attribute|
	      if params[attribute] && params[attribute] != 'All'
	        if attribute == :units
	          session[attribute] = params[attribute].keys
	          params[attribute] = session[attribute]
	        else
	          session[attribute] = params[attribute]
	        end
	      end
	    
	    end

	    #this does not work when you don't put in information about category, status, and units
	    # @courses = Course.find(:all, :order => session[:title], :conditions => {:category => session[:category], :status => session[:status], 
	    # :units => session[:units]})
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
	    	@courses = Course.find(:all, :order => session[:title], :conditions => {:pending => false})
	    	#NOT IMPLEMENTED YET
	    	#TODO: ERIC
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
end