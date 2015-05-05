class Section < ActiveRecord::Base
  attr_accessible :ccn_ld, :ccn_publish, :ccn_ud, :facilitator, :first_day, :location, :section_title, :size, :status, 
  :days, :start_time, :end_time, :course_id, :start_int, :end_int
  belongs_to :course, :class_name => "Course", :foreign_key => "course_id"
  
  validates_presence_of :section_title, :status, :days, :start_time, :end_time, :location

  before_save :store_time 
  after_find :unstore_time

  def self.filter input, output
    section = Section.arel_table
    output = output.where(section[:status].eq_any input[:status]) if input[:status]
    output = output.where('start_int >= ?', time_to_int(input[:start_time])) if !input[:start_time].blank?
    output = output.where('end_int <= ?', time_to_int(input[:end_time])) if !input[:end_time].blank?
    if input[:days]
      new = input[:days].collect {|t| "%#{t}%"}
      output = output.where(section[:days].matches_any new)
    end
    output
  end

  def self.need_to_filter input
    input.delete(:start_time) if input[:start_time].blank?
    input.delete(:end_time) if input[:end_time].blank?
    input[:start_time] || input[:end_time] || input[:status]
  end
    
  def self.all_days
    ["M", "Tu", "W", "Th", "F"]
  end

  def self.all_times
    (0...29).map {|i| int_to_time(i * 30 + (8 * 60))}
  end

  def self.statuses
    ["Open", "Full"]
  end

  def filled?
    !days.blank? and start_time and end_time
  end

  def full_time
    full = days.join 
    full += " " + start_time if start_time
    full += "-" + end_time if end_time
    full = full.to_s
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

  private
    def store_time
      self.days = self.days.join if self.days
      self.start_int = Section.time_to_int self.start_time
      self.end_int = Section.time_to_int self.end_time
    end

    def unstore_time
      self.days =~ /(M)?(Tu)?(W)?(Th)?(F)?/
      output = []
      output.push($1) if $1
      output.push($2) if $2
      output.push($3) if $3
      output.push($4) if $4
      output.push($5) if $5
      self.days = output
    end
end
