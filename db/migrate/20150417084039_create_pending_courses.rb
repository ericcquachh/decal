class CreatePendingCourses < ActiveRecord::Migration
  def change
    create_table :pending_courses do |t|
      t.string :title
      t.string :category
      t.string :units
      t.string :time
      t.string :status
      t.string :department_num
      t.boolean :cs_fw
      t.string :description
      t.string :enrollment_info
      t.string :course_email
      t.string :course_website
      t.string :faculty_name
      t.string :faculty_email
      t.timestamps
    end
  end
end
