class RemoveAndAddUid < ActiveRecord::Migration
  def change
  	remove_column :courses, :uid, :string
  	add_column :courses, :uid, :integer
  end
end
