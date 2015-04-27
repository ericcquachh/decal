class AddAppDueDateToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :application_due, :date
  end
end
