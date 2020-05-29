class CreateUserLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_links do |t|
      t.integer :user_id
      t.integer :link_id
      t.json :userdata

      t.timestamps
    end
  end
end
