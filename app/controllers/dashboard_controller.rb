class DashboardController < ApplicationController
	def delete
	    @course = Course.find(params[:id])
	    @course.destroy
	    redirect_to dashboard_index_path
	end

	def create
		params.keys.each do |key|
			if params[key] == "1"
				# test.push(key)
				course = Course.find_by_title(key)
				course.update_attributes(uid: nil)
			end
		end
		redirect_to dashboard_path
	end

	def show
		render :existing
	end
end
