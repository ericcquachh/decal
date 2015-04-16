class Course < ActiveRecord::Base
  attr_accessible :category, :status, :title, :units, :uid, :department_num, :cs_fw, :description, :enrollment_info, :course_email, :course_website, :faculty_name, :faculty_email, :pending
  attr_writer :current_step

  has_many :sections
  has_many :uploads
  has_many :section_times, through: :sections
  has_many :courses_users
  has_many :users, through: :courses_users

  CATEGORIES = ["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science"]

  validates_presence_of :title, :units, :if => lambda { |o| o.current_step == "1" }
  validates_inclusion_of :category, :in => CATEGORIES, :if => lambda { |o| o.current_step == "1" }, :message => "You must choose a category from the dropdown selection."
  validates_inclusion_of :status, :in => ["Open", "Full"], :if => lambda { |o| o.current_step == "1" }, :message => "You must choose a status from the dropdown selection."  

  validates_presence_of :department_num, :course_email, :faculty_email, :faculty_name, :if => lambda { |o| o.current_step == "2" }
  validates_presence_of :description, :enrollment_info, :if => lambda { |o| o.current_step == "3"}

  # validates :title, :presence => {message: "Title is required."}
  # validates :units, :presence => {message: "Units cannot be blank."}, :numericality => {only_integer: true, :greater_than => 0, :less_than => 5, message: "Units must be integers 1-4."} 
  # validates :category, :inclusion => {in: CATEGORIES, message: "You must choose a category from the dropdown selection."}

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

  def self.all_attributes
    {:title => nil, :category => self.categories + ["All"], :status => self.statuses, :units => self.units}
  end

  # Changed to make validations work
  def self.categories
    CATEGORIES
  end

  def verify_facilitator? user_id
    return self.courses_users.find_by_user_id(user_id) != nil
  end

  def self.units
    ["1", "2", "3", "4"]
  end

  def self.statuses
    ["Full", "Open", "All"]
  end

  def self.uid
    :uid
  end
end
