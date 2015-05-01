class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json

  before_filter :logged_in, :except => [:index, :show]

  def index
    @courses = Course.filter params, false
  end

  def makeadmin
    current_user.update_attribute :admin, true
    redirect_to :root, notice: "User is now God."
  end

  def removeadmin
    current_user.update_attribute :admin, false
    redirect_to :root, notice: "User is now a peasant."
  end

  # Controller action for favorite courses
  def favorites
    @course = Course.find(params[:id])
    FavoriteCourse.create!(course_id: @course.id, user_id: current_user.id)
    redirect_to course_path(:id => @course.id)
  end

  def unfavorite
    @course = Course.find(params[:id])
    FavoriteCourse.destroy_all(course_id: @course.id, user_id: current_user.id)
    redirect_to dashboard_index_path
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new  
  # GET /courses/new.json
  def new
    session[:course_params] ||= {}
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json

  def create
    session[:course_params].deep_merge!(params[:course]) if params[:course]
    @course = Course.new(session[:course_params])
    @course.facilitators << current_user
    @course.current_step = session[:course_step]
    if @course.valid?
      if params[:previous_button]
        @course.previous_step
      elsif @course.last_step?
        if @course.all_valid?
          @course.pending = true
          @course.has_syl = false
          @course.has_cpf = false
          @course.save
        end
      else
        @course.next_step
      end
      session[:course_step] = @course.current_step
    end
    if @course.new_record?
      render 'new'
    else
      session[:course_step] = session[:course_params] = nil
      flash[:notice] = "Course successfully requested. Please submit your CPF and Syllabus in order to get course approved by admin."
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def facilitator_request
    FacilitateRequest.create!(request_id: current_user.id, receiver_id: params[:id])
    redirect_to course_path(:id => params[:id])
  end


end
