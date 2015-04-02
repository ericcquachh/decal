class RemoveColumnFromModel < ActiveRecord::Migration
  def change
  	remove_column :users, :facilitator
  end
end
