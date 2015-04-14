class ExistingCoursesController < ApplicationController
	def index
	    if current_user.nil? || !(user_signed_in?)
	    	redirect_to :root, notice: 'make sure you login fool'
	    else
	    	if current_user.courses == []
	    		@courses = Course.all()
	    	else
		    	@courses = Course.where('id NOT IN (?)', current_user.courses)
		    end
	    end
	end

	def create
		params.keys.each do |key|
			if params[key] == "1"
				course = Course.find_by_title(key)
				CoursesUser.create!(user_id: current_user.id, course_id: course.id)
			end
		end
		redirect_to dashboard_index_path
	end
end