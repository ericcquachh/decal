class ChangeUidToInteger < ActiveRecord::Migration
  def change
  	change_column :courses, :uid, :integer
  end
end
