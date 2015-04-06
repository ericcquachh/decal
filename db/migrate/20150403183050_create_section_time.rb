class CreateSectionTime < ActiveRecord::Migration
  def change
    create_table :section_times do |t|
      t.string :days
      t.string :start_time
      t.string :end_time
      t.timestamps
    end
    remove_column :courses, :days
    remove_column :courses, :time
    remove_column :sections, :start_time
    remove_column :sections, :end_time
  end
end
