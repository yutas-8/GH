class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :member_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_

      t.timestamps
    end
  end
end
