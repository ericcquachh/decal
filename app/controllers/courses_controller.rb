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

    #this does not work when you don't put in information about category, status, and units
    @courses = Course.find(:all, :order => session[:title], :conditions => {:category => session[:category], :status => session[:status], 
    :units => session[:units]})

    # @courses = Course.find(:all, :order => session[:title])

    if params[:search_field]
      @courses = @courses.select {|course| course.title.downcase.include? params[:search_field].downcase}
    end
  end

  def promote
    current_user.update_attribute :facilitator, true
    redirect_to :root, notice: "User promoted to facilitator"
  end

  def demote
    current_user.update_attribute :facilitator, false
    redirect_to :root, notice: "User demoted to basic user"
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
    # @course = Course.new(params[:course])
    current_user.courses.create(params[:course])
    current_user.save!
    redirect_to :root, :notice => params
  end

  # def addsection
  #   @section = Section.new
  # end

  # def updatesection
  #   @section = Section.new(params[:section])
  #   @section.course = Course.find(params[:id])
  #   @section.save!
  #   redirect_to :root, :notice => params
  # end

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
