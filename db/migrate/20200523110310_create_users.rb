class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :address
      t.string :password_digest
      t.string :remember_token
      t.string :nickname

      t.timestamps
    end
  end
end
