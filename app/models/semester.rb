class Semester < ActiveRecord::Base
  attr_accessible :name

  def self.semesters
    self.all.map {|t| t.name }
  end

  def self.current_semester param
    return param if param
    time = Time.now
    output = time.month > 6 ? 'Fall ' : 'Spring '
    output += time.year.to_s
  end

end
