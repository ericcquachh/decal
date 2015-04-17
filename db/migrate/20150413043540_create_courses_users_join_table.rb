class CreateCoursesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
      t.integer :course_id, :default => -1
      t.integer :user_id, :default => -1
    end
  end
end
