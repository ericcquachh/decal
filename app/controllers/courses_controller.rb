class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @all_units = ["1", "2","3","4"]
    @all_categories = ["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science", "All"]
    @selected_units = {}
    @selected_categories = []
    @existing_session = false
    @curr_category = "All"
    @test = "lol"

    if params[:title] == 'title'
      session[:title] = params[:title]
      @courses = Course.all(:order => "title ASC")
    elsif session.has_key?(:title)
      params[:title] = session[:title]
      @existing_session = true
    end

    if params[:checked_units]
      @selected_categories = params[:checked_units]
      session[:checked_units] = params[:checked_units]
      @courses = @courses.find_all{|u| params[:checked_units].include?(u.units)}
    elsif session.has_key?(:checked_units)
      params[:checked_units] = session[:checked_units]
      @existing_session = true
    end

    if params[:selected_categories]
      session[:selected_categories] = params[:selected_categories]
      @curr_category = params[:selected_categories][0]
      if params[:selected_categories][0] != "All"
        @courses = @courses.find_all{|c| params[:selected_categories].include?(c.category)}
        @test = params[:selected_categories].size
      end
    elsif session.has_key?(:selected_categories)
      params[:selected_categories] = session[:selected_categories]
      @existing_session = true
    end

    if @existing_session
      redirect_to courses_path(:title => params[:title], :checked_units => params[:checked_units], :selected_categories => params[:checked_units])
    end

    @all_units.each { |unit|
      if params[:checked_units]
        @selected_units[unit] = params[:checked_units].include?(unit)
      else
        @selected_units[unit] = false
      end
    }

    @selected_categories = params[:selected_categories]
  
    if session.empty?
      @all_units.each { |unit| @selected_units[unit] = true}
      @selected_categories = @all_categories
    end

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @courses }
    # end
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
