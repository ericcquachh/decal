class FacilitateRequest < ActiveRecord::Base
  attr_accessible :receiver_id, :request_id
  belongs_to :receiver, :class_name => "Course"
  belongs_to :request,  :class_name => "User"

  validates_uniqueness_of :receiver_id, :scope => :request_id
end
