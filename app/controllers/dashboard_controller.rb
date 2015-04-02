class DashboardController < ApplicationController
	def delete
	    @course = Course.find(params[:id])
	    @course.destroy
	    redirect_to dashboard_index_path
	end
end
