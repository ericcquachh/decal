class Section < ActiveRecord::Base
  attr_accessible :ccn_ld, :ccn_publish, :ccn_ud, :facilitator, :first_day, :location, :section_title, :size, :status, :days,
  :start_time, :end_time
  belongs_to :course, :class_name => "Course", :foreign_key => "course_id"

  def days
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
  end

  def filter_time time
    time = Time.parse(params[:section]['start_time(4i)'] + ':' + params[:section]['start_time(5i)']).strftime("%I:%M%p")
    params[:section][:end_time] = Time.parse(params[:section]['end_time(4i)'] + ':' + params[:section]['end_time(5i)']).strftime("%I:%M%p")
  end
end
