class Section < ActiveRecord::Base
  attr_accessible :ccn_ld, :ccn_publish, :ccn_ud, :facilitator, :first_day, :location, :section_title, :size, :status, :days,
  :start_time, :end_time, :sid
  belongs_to :course, :class_name => "Course", :foreign_key => "course_id"
  has_one :section_time, :class_name => "Section_time", :dependent => :destroy

end
