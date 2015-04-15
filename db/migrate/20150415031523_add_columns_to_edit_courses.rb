class AddColumnsToEditCourses < ActiveRecord::Migration
  def change
    add_column :courses, :department_num, :string
    add_column :courses, :cs_fw, :boolean
    add_column :courses, :description, :string
    add_column :courses, :enrollment_info, :string
    add_column :courses, :course_email, :string
    add_column :courses, :course_website, :string
    add_column :courses, :faculty_name, :string
    add_column :courses, :faculty_email, :string
  end
end
