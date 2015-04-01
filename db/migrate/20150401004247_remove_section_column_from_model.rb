class RemoveSectionColumnFromModel < ActiveRecord::Migration
  def change
  	remove_column :courses, :section
  end
end
