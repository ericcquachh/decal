class AddFacilitatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facilitator, :boolean, :default => false
  end
end
