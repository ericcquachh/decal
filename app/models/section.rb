class Section < ActiveRecord::Base
	attr_accessible :ccn_ld, :ccn_publish, :ccn_ud, :facilitator, :first_day, :location, :section_title, :size, :status
	belongs_to :course, :class_name => "Course", :foreign_key => "course_id"

end
