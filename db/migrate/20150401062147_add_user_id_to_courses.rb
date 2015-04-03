class AddUserIdToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :uid, :integer, :default => -1
  end
end
