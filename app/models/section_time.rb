class Section_time < ActiveRecord::Base
  attr_accessible :days, :start_time, :end_time
  belongs_to :section

  def self.all_days
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
  end

  def self.all_times
    (0...29).map {|i| int_to_time(i * 30 + (8 * 60))}
  end

  def include_day? days
    Section_time.days_nerf(days).any? {|day| :days.to_s.include? day}
  end

  def include_time? times
    (Section_time.time_to_int(times[:start_time]) < Section_time.time_to_int(:start_time)) and (Section_time.time_to_int(times[:end_time]) >= Section_time.time_to_int(:end_time))
  end

  def self.time_to_int time
    time =~ /(\d+):(\d+)(P)?(A)?M/
    new = $1.to_i * 60 + $2.to_i
    if $3
      new + 720
    else 
      new
    end
  end

  def self.int_to_time int
    pm = false
    if int > 720
      int -= 720
      pm = true
    end
    time = (int / 60).to_s + ":" + (int % 60).to_s
    time += 0.to_s if int % 60 == 0
    if pm 
      time += "PM"
    else
      time += "AM"
    end
  end

  def self.filter_time_and_date input
    new = {}
    new[:start_time] = Time.parse(input['start_time(4i)'] + ':' + input['start_time(5i)']).strftime("%I:%M%p")
    new[:end_time] = Time.parse(input['end_time(4i)'] + ':' + input['end_time(5i)']).strftime("%I:%M%p")
    if input[:days] 
      new[:days] = input[:days].keys
    end
    new
  end

  def self.days_nerf days
    output = []
    days.each do |day|
      case day
      when "Monday"
        output.push("M")
      when "Tuesday"
        output.push("Tu")
      when "Wednesday"
        output.push("W")
      when "Thursday"
        output.push("Th")
      when "Friday"
        output.push("F")
      end
    end
    output
  end
end
