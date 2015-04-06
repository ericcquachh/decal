class DashboardController < ApplicationController
	def delete
	    @course = Course.find(params[:id])
	    @course.destroy
	    redirect_to dashboard_index_path
	end

	def index
	    if current_user.nil? || !(user_signed_in?)
	    	redirect_to :root, notice: 'make sure you login fool'
	    end
	end

	def create
		params.keys.each do |key|
			if params[key] == "1"
				course = Course.find_by_title(key)
				course.update_attributes(uid: -1)
			end
		end
		redirect_to dashboard_path
	end

	def show
		render :existing
	end
end
