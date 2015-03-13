class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @all_units = Course.units
    @all_categories = Course.categories
    @all_status = Course.statuses

    if params[:search_field]
      @courses = Course.search(params[:search_field])
    end

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

    # if params[:title] == 'title'
    #   session[:title] = @sort_title
    #   @courses.sort_by!{ |course| course.title.downcase }
    # end
    if @sort_title
      if params[:title] != session[:title]
        session[:title] = @sort_title
      end
      @courses.sort_by!{ |course| course.title.downcase }
    end
    # @memberships.sort_by!{ |m| m.group.name.downcase }

    # if params[:checked_units]
    #   @selected_categories = params[:checked_units]
    #   session[:checked_units] = params[:checked_units]
    #   @courses = @courses.find_all{|u| params[:checked_units].include?(u.units)}
    # elsif session.has_key?(:checked_units)
    #   params[:checked_units] = session[:checked_units]
    #   @existing_session = true
    # end

    # if params[:selected_categories]
    #   session[:selected_categories] = params[:selected_categories]
    #   #currently a hacky way to support selecting just ONE category. Need to alter cucumber to this OR enable multiple selecting (Easy)
    #   @selected_category = params[:selected_categories][0]
    #   if params[:selected_categories][0] != "All"
    #     @courses = @courses.find_all{|c| params[:selected_categories].include?(c.category)}
    #   end
    # elsif session.has_key?(:selected_categories)
    #   params[:selected_categories] = session[:selected_categories]
    #   @existing_session = true
    # end

    # if params[:selected_status]
    #   session[:selected_status] = params[:selected_status]
    #   @selected_status = params[:selected_status]
    #   if params[:selected_status][0] != "All"
    #     @courses = @courses.find_all{|c| params[:selected_status].include?(c.status)}
    #   end
    # elsif session.has_key?(:selected_status)
    #   params[:selected_status] = session[:selected_status]
    #   @existing_session = true
    # end

    # @all_units.each { |unit|
    #   if params[:checked_units]
    #     @selected_units[unit] = params[:checked_units].include?(unit)
    #   else
    #     @selected_units[unit] = false
    #   end
    # }

    # @selected_categories = params[:selected_categories]
    # @selected_status = params[:selected_status]
  
    # if session.empty?
    #   @all_units.each { |unit| @selected_units[unit] = true}
    #   @selected_categories = @all_categories
    #   @selected_status = "All"
    # end

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
