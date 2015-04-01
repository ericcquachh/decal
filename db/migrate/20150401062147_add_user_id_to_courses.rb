class AddUserIdToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :uid, :string
  end
end
