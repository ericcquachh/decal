class CreateFacilitateRequestsJoinTable < ActiveRecord::Migration
  def change
    create_table :facilitate_requests do |t|
      t.integer :request_id, :default => -1
      t.integer :receiver_id, :default => -1
      t.timestamps
    end
  end
end
