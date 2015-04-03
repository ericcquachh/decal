class RemoveDaysFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :days
    remove_column :courses, :time
  end

  def down
  end
end
