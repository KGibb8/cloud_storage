class CreateAccountUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :account_users do |t|
      t.references :user, foreign_key: true, index: true
      t.references :account, foreign_key: true, index: true

      t.timestamps
    end
  end
end
