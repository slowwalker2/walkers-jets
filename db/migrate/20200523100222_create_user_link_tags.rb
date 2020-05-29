class CreateUserLinkTags < ActiveRecord::Migration[6.0]
  def change
    create_table :user_link_tags do |t|
      t.integer :user_id
      t.integer :user_link_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
