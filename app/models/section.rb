class Section < ActiveRecord::Base
  attr_accessible :ccn_ld, :ccn_publish, :ccn_ud, :facilitator, :first_day, :location, :section_title, :size, :status, 
  :days, :start_time, :end_time, :sid, :course_id
  belongs_to :course, :class_name => "Course", :foreign_key => "course_id"

  def self.filter input, output
    output = output.where('status = ?', input[:status]) if input[:status]
    output = output.where('start_time >= ?', time_to_int(input[:start_time])) if input[:start_time]
    output = output.where('end_time <= ?', time_to_int(input[:end_time])) if input[:end_time]
    if input[:days]
      section = Section.arel_table
      new = input[:days].collect {|t| "%#{t}%"}
      output = output.where(section[:days].matches_any new)
    end
    output
  end

  def self.need_to_filter input
    normalize! input
    input[:start_time] || input[:end_time] || input[:status]
  end
    
  def self.all_days
    ["M", "Tu", "W", "Th", "F"]
  end

  def self.all_times
    (0...29).map {|i| int_to_time(i * 30 + (8 * 60))}
  end

  def self.statuses
    ["Open", "Started", "Full"]
  end

  def filled?
    days and start_time and end_time
  end

  def full_time
    full = days if days
    full += " " + Section.int_to_time(start_time) if start_time
    full += "-" + Section.int_to_time(end_time) if end_time
    full
  end

  def self.time_to_int time
    time =~ /(\d+):(\d+)(P)?(A)?M/
    new = $1.to_i * 60 + $2.to_i
    (($1.to_i != 12) and $3) ? new + 720 : new
  end

  def self.int_to_time int
    pm = (int >= 720)
    int -= 720 if int >= 780
    time = (int / 60).to_s + ":" + (int % 60).to_s
    time += 0.to_s if int % 60 == 0
    pm ? time += "PM" : time += "AM" 
  end

  def self.normalize! input
    input[:days] = input[:days].keys if input[:days]
    input.delete :start_time if input[:start_time] == '-Select Time-'
    input.delete :end_time if input[:end_time] == '-Select Time-'
    input.delete :status if input[:status] == 'Select'
  end

  def self.to_add! input
    input[:days] = input[:days].keys.join("") if input[:days]
    input[:start_time] = time_to_int input[:start_time] if input[:start_time]
    input[:end_time] = time_to_int input[:end_time] if input[:end_time]
  end

end
