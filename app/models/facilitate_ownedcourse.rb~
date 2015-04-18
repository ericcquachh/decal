class FacilitateOwnedcourse < ActiveRecord::Base
  attr_accessible :facilitator_id, :ownedcourse_id
  belongs_to :ownedcourse, :class_name => "Course"
  belongs_to :facilitator,  :class_name => "User"
end
