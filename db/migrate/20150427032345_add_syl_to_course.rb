class AddSylToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :has_syl, :boolean
  end
end
