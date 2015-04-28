class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :section_title
      t.string :facilitator
      t.integer :size
      t.integer :ccn_ld
      t.integer :ccn_ud
      t.boolean :ccn_publish
      t.string :status
      t.string :first_day
      t.string :location
      t.integer :start_time
      t.integer :end_time
      t.integer :course_id
      t.string :days
      t.timestamps
    end
  end
end
