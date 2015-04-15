class Section_time < ActiveRecord::Base
  attr_accessible :days, :start_time, :end_time
  belongs_to :section

  def self.all_days
    ["M", "Tu", "W", "Th", "F"]
  end

  def self.all_times
    ["-Select Time-"] + (0...29).map {|i| int_to_time(i * 30 + (8 * 60))}
  end

  def full_time
    full = ""
    full = days + " " if days
    full += start_time if start_time
    full += '-' + end_time if end_time
    full
  end

  def include_day? dotw
    bool = true
    if dotw
      bool = days_to_list.any? {|day| dotw.include? day}
    end
    bool
  end

  def include_time? param
    return false if !filled?
    if param[:start_time]
      if (Section_time.time_to_int(param[:start_time]) > Section_time.time_to_int(start_time))
        return false
      end
    end
    if param[:end_time]
      if (Section_time.time_to_int(param[:end_time]) < Section_time.time_to_int(end_time))
        return false
      end
    end
    include_day? param[:days]
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

  def self.filter_section_time input
    if input[:days]
      input[:days] = input[:days].keys.join("")
    end
    if input[:start_time] == '-Select Time-'
      input.delete :start_time
    end
    if input[:end_time] == '-Select Time-'
      input.delete :end_time
    end
    input
  end

  def filled?
    days and start_time and end_time
  end

  def days_to_list
    output = []
    days =~ /(M)?(Tu)?(W)?(Th)?(F)?/
    output.push($1) if $1
    output.push($2) if $2
    output.push($3) if $3
    output.push($4) if $4
    output.push($5) if $5
    output
  end
end