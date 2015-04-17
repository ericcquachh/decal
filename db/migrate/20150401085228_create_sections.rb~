class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :section_title
      t.string :facilitator
      t.integer :size
      t.integer :ccn_ld
      t.integer :ccn_ud
      t.boolean :ccn_publish
      t.boolean :status
      t.string :first_day
      t.string :location
      t.timestamps
    end
  end
end
