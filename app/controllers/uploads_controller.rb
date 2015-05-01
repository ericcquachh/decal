class UploadsController < ApplicationController

  before_filter :logged_in, :except => [:index, :show]
  before_filter :is_facilitator, :only => [:destroy]

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
    if params[:syl] or params[:cpf]
      params[:upload][:syl] = params[:syl]
      params[:upload][:cpf] = params[:cpf]
    end
    @upload.syl = params[:upload][:syl]
    @upload.cpf = params[:upload][:cpf]
    @upload.course = Course.find(params[:course_id])
    if @upload.syl and @upload.cpf
      redirect_to new_course_upload_path(params[:course_id]), notice: "An upload can't act as both a CPF and a Syllabus"
  	elsif @upload.save
      if @upload.syl
        @upload.course.update_attribute(:has_syl, true)
        Upload.where(syl: true).find_each do |upload|
          if upload != @upload
            upload.destroy
          end
        end
        redirect_to course_path(params[:course_id]), notice: "The syllabus #{@upload.name} has been uploaded and overwritten any old syllabus."
      elsif @upload.cpf
        @upload.course.update_attribute(:has_cpf, true)
        Upload.where(cpf: true).find_each do |upload|
          if upload != @upload
            upload.destroy
          end
        end
        redirect_to course_path(params[:course_id]), notice: "The CPF #{@upload.name} has been uploaded and overwritten any old CPF."
      else
        redirect_to course_path(params[:course_id]), notice: "The upload #{@upload.name} has been uploaded."
      end
    else
      redirect_to new_course_upload_path(params[:course_id]), notice: @upload.errors.full_messages.to_s
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.syl
      @upload.course.update_attribute(:has_syl, false)
    elsif @upload.cpf
      @upload.course.update_attribute(:has_cpf, false)
    end
    @upload.destroy
    

    redirect_to course_path(params[:course_id]), notice:  "The upload #{@upload.name} has been deleted."
  end

# private
#   def upload_params
#     params.require(:upload).permit(:name, :attachment)
#   end
end
