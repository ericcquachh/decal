class Course < ActiveRecord::Base
  attr_accessible :category, :status, :title, :units, :uid
  has_many :sections
  has_many :uploads
  has_many :users
  has_many :section_times, through: :sections

  CATEGORIES = ["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science"]

  validates :title, :presence => {message: "Title is required."}
  validates :units, :presence => {message: "Units cannot be blank."}, :numericality => {only_integer: true, :greater_than => 0, :less_than => 5, message: "Units must be integers 1-4."} 
  validates :category, :inclusion => {in: CATEGORIES, message: "You must choose a category from the dropdown selection."}


  def self.all_attributes
    {:title => nil, :category => self.categories + ["All"], :status => self.statuses, :units => self.units}
  end

  # Changed to make validations work
  def self.categories
    CATEGORIES
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
