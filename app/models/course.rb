class Course < ActiveRecord::Base
  attr_accessible :category, :status, :days, :time, :title, :units

  def self.all_attributes
    {:category => self.categories, :status => self.statuses, :days => self.days, :time => self.times, :units => self.units}
  end

  def self.categories
    ["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science", "All"]
  end

  def self.units
    [1, 2, 3, 4]
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

  def self.search(input)
  	broad_search_condition = "%" + input + "%"
  	find(:all, :conditions => ['title LIKE ?', broad_search_condition])
  end
end
