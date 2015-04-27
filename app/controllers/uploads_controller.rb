class UploadsController < ApplicationController
  before_filter :logged_in, :except => [:index, :show]
  before_filter :is_facilitator, :only => [:destroy]

  def logged_in
    if current_user.nil? || !(user_signed_in?)
      redirect_to :root, notice: 'make sure you login fool'
    end
  end

  def is_facilitator
    if !(Course.find(params[:course_id]).verify_facilitator? current_user)
      redirect_to :root, notice: 'You do not have these priveleges'
    end
  end

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

      redirect_to new_course_upload_path(params[:course_id]), notice: @upload.errors.full_messages.to_s
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
