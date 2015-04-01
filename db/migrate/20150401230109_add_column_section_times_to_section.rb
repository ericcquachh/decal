class AddColumnSectionTimesToSection < ActiveRecord::Migration
  def change
    add_column :sections, :start_time, :string
    add_column :sections, :end_time, :string
  end
end
