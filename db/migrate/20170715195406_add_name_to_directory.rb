class AddNameToDirectory < ActiveRecord::Migration[5.0]
  def change
    add_column :directories, :name, :string
  end
end
