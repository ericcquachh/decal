class Course < ActiveRecord::Base
  attr_accessible :category, :status, :days, :time, :title, :units

  def self.search(input)
  	broad_search_condition = "%" + input + "%"
  	find(:all, :conditions => ['title LIKE ?', broad_search_condition])
  end

  def self.units
  	["1", "2","3","4"]
  end

  def self.categories
  	["Computer Science", "Fitness", "Business", "Languages", "Cognitive Science", "All"]
  end

  def self.statuses
  	["Open", "Full", "All"]
  end
end
