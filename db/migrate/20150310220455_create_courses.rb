class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :category
      t.string :department_num
      t.string :semester
      t.boolean :cs_fw
      t.string :description
      t.string :enrollment_info
      t.string :course_email
      t.string :course_website
      t.string :faculty_name
      t.string :faculty_email
      t.boolean :pending
      t.string :units
      t.timestamps
    end
  end
end
