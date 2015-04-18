class FacilitateOwnedcourse < ActiveRecord::Base
  attr_accessible :facilitator_id, :ownedcourse_id
  belongs_to :ownedcourse, :class_name => "Course"
  belongs_to :facilitator,  :class_name => "User"

  validates_uniqueness_of :facilitator_id, :scope => :ownedcourse_id
end
