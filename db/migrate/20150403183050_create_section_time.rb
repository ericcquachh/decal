class CreateSectionTime < ActiveRecord::Migration
  def change
    create_table :section_times do |t|
      t.string :days
      t.string :start_time
      t.string :end_time
      t.integer :section_id
      t.timestamps
    end
  end
end
