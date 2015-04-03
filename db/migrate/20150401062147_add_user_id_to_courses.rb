class AddUserIdToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :uid, :integer
  end
end
