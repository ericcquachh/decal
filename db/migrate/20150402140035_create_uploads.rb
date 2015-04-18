class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.string :attachment
      t.integer :course_id
      t.timestamps
    end
  end
end
