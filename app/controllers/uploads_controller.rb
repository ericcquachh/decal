class UploadsController < ApplicationController
  #not sure if we need index; maybe admin will need it
  def index
  	@course = Course.find(params[:course_id])
  	@uploads = Upload.all
  end

  def new
  	@upload = Upload.new
  	@course = Course.find(params[:course_id])
  end

  def create
  	@upload = Upload.new(params[:upload])
  	@upload.course = Course.find(params[:course_id])

  	if @upload.save
      redirect_to course_path(params[:course_id]), notice: "The upload #{@upload.name} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
  	@upload = Upload.find(params[:id])
    @upload.destroy
    redirect_to course_path(params[:course_id]), notice:  "The upload #{@upload.name} has been deleted."
  end

# private
#   def upload_params
#     params.require(:upload).permit(:name, :attachment)
#   end
end
