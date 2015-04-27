class AddCpfToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :cpf, :boolean
  end
end
