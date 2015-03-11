class Course < ActiveRecord::Base
  attr_accessible :category, :status, :days, :time, :title, :units
end
