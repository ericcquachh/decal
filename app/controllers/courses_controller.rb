class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @all_units = Course.units
    @all_categories = Course.categories
    @all_status = Course.statuses

    # if params[:title] == 'title'
    #   session[:title] = params[:title]
    #   @courses = Course.all(:order => "title ASC")
    # elsif session.has_key?(:title)
    #   params[:title] = session[:title]
    #   @existing_session = true
    # end

    # if @existing_session
    #   redirect_to courses_path(:title => params[:title], :checked_units => params[:checked_units], :selected_categories => params[:checked_units], :selected_status => params[:selected_status])
    # end

    @selected_units = params[:checked_units] || session[:checked_units] || Hash.new
    @selected_category = params[:selected_categories] || session[:selected_categories] ||  "All"
    @selected_status = params[:selected_status] || session[:selected_status] || "All"
    @sort_title = params[:title] || session[:title] || nil

    if params[:checked_units] != session[:checked_units]
      session[:checked_units] = @selected_units
    end

    if @selected_category != "All" and (params[:selected_category] != session[:selected_category])
      session[:selected_category] = @selected_category
    end

    if @selected_status != "All" and (params[:selected_status] != session[:selected_status])
      session[:selected_status] = @selected_status
    end

    if @selected_category == "All" and @selected_status == "All" and @selected_units.size != 0
      @courses = Course.where(:units => (@selected_units.keys))
    elsif @selected_category == "All" and @selected_status != "All"
      @courses = Course.where(:units => (@selected_units.keys), :status => @selected_status)
    elsif @selected_category != "All" and @selected_status == "All"
      @courses = Course.where(:units => (@selected_units.keys), :category => @selected_category)
    elsif @selected_category != "All" and @selected_status != "All"
      @courses = Course.where(:units => (@selected_units.keys), :category => @selected_category, :status => @selected_status)
    end

    # function for sorting the title
    if @sort_title
      if params[:title] != session[:title]
        session[:title] = @sort_title
      end
      @courses.sort_by!{ |course| course.title.downcase }
    end

    # function for searching
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
