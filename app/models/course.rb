class Course < ActiveRecord::Base
  attr_accessible :category, :status, :title, :units, :uid
  has_many :sections
  has_many :uploads

  validates :title, :presence => true
  validates :units, :presence => true
  validates :category, :presence => true

  def self.all_attributes
    {:title => nil, :category => self.categories, :status => self.statuses, :units => self.units}
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

  def self.uid
  end
end
