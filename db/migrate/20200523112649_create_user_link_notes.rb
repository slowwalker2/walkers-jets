class CreateUserLinkNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_link_notes do |t|
      t.integer :user_id
      t.integer :user_link_id
      t.text :body

      t.timestamps
    end
  end
end
