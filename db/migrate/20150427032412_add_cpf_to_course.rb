class AddCpfToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :has_cpf, :boolean
  end
end
