class Course < ActiveRecord::Base
  attr_accessible :category, :status, :time, :title, :units
end
