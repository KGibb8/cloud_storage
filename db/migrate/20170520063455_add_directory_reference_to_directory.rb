class AddDirectoryReferenceToDirectory < ActiveRecord::Migration[5.0]
  def change
    add_reference :directories, :directory, foreign_key: true
  end
end
