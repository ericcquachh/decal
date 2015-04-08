class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :category
      t.string :units
      t.string :time
      t.string :status

      t.timestamps
    end

    remove_column :courses, :days
    remove_column :courses, :time
  end
end
