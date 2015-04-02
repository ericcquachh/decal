class AddCourseIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :course_id, :integer
  end
end
