class AddPendingToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :pending, :boolean
  end
end
