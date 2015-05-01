class Course < ActiveRecord::Base
 attr_accessible :semester, :category, :title, :units, :uid, :department_num, :cs_fw, :description,
 :enrollment_info, :course_email, :course_website, :faculty_name, :faculty_email, :pending, :application_url, :application_due, 
 :has_cpf, :has_syl

  attr_writer :current_step

  has_many :sections, dependent: :destroy
  has_many :uploads, dependent: :destroy

  has_and_belongs_to_many :favorite_users, join_table: :favorite_courses, class_name: "User"
  before_destroy { favorite_users.clear }

  has_many :facilitate_ownedcourses, foreign_key: :ownedcourse_id
  has_many :facilitators, through: :facilitate_ownedcourses, source: :facilitator

  has_many :facilitate_requests, foreign_key: :receiver_id
  has_many :requests, through: :facilitate_requests, source: :request

  validates_presence_of :title, :department_num, :faculty_email, :faculty_name,  :if => lambda { |o| o.current_step == "1" }

  validates :application_url, :if => lambda { |o| o.current_step == "3" }, :allow_blank => true, :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  # validates :application_due, :if => lambda { |o| o.current_step == "3" }, date: { allow_blank: true, after: Proc.new { Time.now }, before: Proc.new { Time.now + 1.year }, message: '... Please enter an upcoming date' }
  validates_date :application_due, :if => lambda { |o| o.current_step == "3" }, :on_or_after => lambda { Date.current }, :allow_blank => true, :on_or_after_message => '... Please enter an upcoming date'

  # Proc is a data structure so the categories can be accessed
  validates_inclusion_of :category, :in => proc{Category.categories}, :if => lambda { |o| o.current_step == "1" }, :message => "must be selected from the dropdown menu"

  validates_presence_of :description, :if => lambda { |o| o.current_step == "2" }
  validates_presence_of :enrollment_info, :if => lambda { |o| o.current_step == "3"}

  # validates :title, :presence => {message: "Title is required."}
  # validates :units, :presence => {message: "Units cannot be blank."} 

  # Changed to make validations work

  def self.filter input, pending
    output = Course.select("DISTINCT courses.*").where(:semester => Semester.current_semester(input[:semester])).where(:pending => pending)
    output = Section.need_to_filter(input) ? output.joins(:sections) : output.joins("LEFT JOIN \"sections\"")
    output = output.where(:category => input[:category]) if input[:category]
    output = output.where('title like ?', "%#{input[:search_field]}%") if !input[:search_field].blank?
    if input[:units]
      course = Course.arel_table
      new = input[:units].collect {|t| "%#{t}%"}
      output = output.where(course[:units].matches_any new)
    end
    output = Section.filter input, output
    output = output.order(sorting[input[:sort]]) if sorting[input[:sort]]
    output
  end

  def self.sorting
    {'Date posted, oldest first' => 'created_at DESC', 'Date posted, newest first' => 'created_at ASC',
     'Title, alphabetically' => 'title'}
  end

  def self.units
    ["1", "2", "3"]
  end

  def self.add_units
    ["1", "2", "3", "1-2", "1-3", "2-3"]
  end

  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[1 2 3]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def verify_facilitator? user
    return false if !user
    user.admin or self.facilitators.include? user
  end

end
