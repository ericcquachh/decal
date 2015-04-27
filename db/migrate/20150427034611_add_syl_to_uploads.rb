class AddSylToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :syl, :boolean
  end
end
