class AddUrlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :application_url, :string
  end
end
