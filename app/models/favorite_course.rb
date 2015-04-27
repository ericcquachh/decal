class FavoriteCourse < ActiveRecord::Base
  attr_accessible :user_id, :course_id
  belongs_to :users
  belongs_to :courses
end
