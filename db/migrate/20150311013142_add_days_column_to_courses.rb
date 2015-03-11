class AddDaysColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :days, :string
  end
end
