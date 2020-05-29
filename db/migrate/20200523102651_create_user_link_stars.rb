class CreateUserLinkStars < ActiveRecord::Migration[6.0]
  def change
    create_table :user_link_stars do |t|
      t.integer :user_id
      t.integer :user_link_id
      t.integer :kind
      t.integer :value

      t.timestamps
    end
  end
end
