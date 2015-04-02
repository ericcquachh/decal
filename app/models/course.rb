class Course < ActiveRecord::Base
  attr_accessible :category, :status, :days, :time, :title, :units, :uid
  has_many :sections

  validates :title, :presence => true
  validates :units, :presence => true
  validates :status, :presence => true
  validates :category, :presence => true

  def self.all_attributes
    {:title => nil, :category => self.categories, :status => self.statuses, :days => self.days, :time => self.times, :units => self.units}
  end

  def self.categories
    ["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science", "All"]
  end


  def self.units
    ["1", "2", "3", "4"]
  end

  def self.statuses
    ["Full", "Open", "All"]
  end

  def self.days
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
  end

  def self.times
    []
  end

  def self.uid
  end
end
