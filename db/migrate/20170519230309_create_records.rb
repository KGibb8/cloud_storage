class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.references :directory, foreign_key: true

      t.timestamps
    end
  end
end
