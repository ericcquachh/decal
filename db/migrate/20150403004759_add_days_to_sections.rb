class AddDaysToSections < ActiveRecord::Migration
  def up
    add_column :sections, :days, :string
  end
end
