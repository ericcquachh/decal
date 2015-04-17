class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json

  before_filter :authorize, :except => [:index, :show]

  def authorize
    if current_user.nil? || !(user_signed_in?)
      redirect_to :root, notice: 'make sure you login fool'
    end
  end

  def index
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
    @courses = Course.find(:all, :order => session[:title], :conditions => {:pending => false})
    # @courses = Course.find(:all, :order => session[:title])

    if params[:search_field]
      @courses = @courses.select {|course| course.title.downcase.include? params[:search_field].downcase}
    end
    if params[:section_time]
      params[:section_time] = Section_time.filter_section_time params[:section_time]
      @courses = @courses.select {|course| course.section_times.any? {|time| time.include_time? params[:section_time]}}
    end
  end

  def makeadmin
    current_user.update_attribute :admin, true
    redirect_to :root, notice: "User is now God."
  end

  def removeadmin
    current_user.update_attribute :admin, false
    redirect_to :root, notice: "User is now a peasant."
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
    @course.current_step = session[:course_step]
    if @course.valid?
      if params[:previous_button]
        @course.previous_step
      elsif @course.last_step?
        if @course.all_valid?
          @course.pending = true
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
      flash[:notice] = "Course saved."
      redirect_to @course
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

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def facilitate_request
    @course = Course.find(params[:course_id])
    FacilitateRequest.create(:request_id => current_user.id, :receiver_id => @course.id)
    redirect_to @course
  end
    
end
