class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @all = Course.all_attributes
    @attributes = @all.keys

    @attributes.each do |attribute|
      session[attribute] = @all[attribute]
    end
    @attributes.each do |attribute|
      if params[attribute] && params[attribute] != 'All'
        if attribute == :days || attribute == :units
          session[attribute] = params[attribute].keys
        else
          session[attribute] = params[attribute]
        end
      end
    end

    @courses = Course.find(:all,:order => session[:title], :conditions => {:category => session[:category], :status => session[:status], 
    :units => session[:units]})

    if params[:search_field]
      new_courses_array = []
      @courses.each do |course|
        if course.title.downcase.include? params[:search_field].downcase
          new_courses_array.push(course)
        end
      end
      @courses = new_courses_array
    end
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
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
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
end
