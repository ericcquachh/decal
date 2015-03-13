class Course < ActiveRecord::Base
  attr_accessible :category, :status, :days, :time, :title, :units

  def self.search(input)
  	broad_search_condition = "%" + input + "%"
  	find(:all, :conditions => ['title LIKE ?', broad_search_condition])
  end
end
