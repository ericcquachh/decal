class ExistingCoursesController < ApplicationController
	def index
	    if current_user.nil? || !(user_signed_in?)
	    	redirect_to :root, notice: 'make sure you login fool'
	    else
			@courses = Course.where("uid != ?", current_user.id)
	    end
	end

	def create
		params.keys.each do |key|
			if params[key] == "1"
				course = Course.find_by_title(key)
				course.update_attributes(uid: current_user.id)
			end
		end
		redirect_to dashboard_index_path
	end
end