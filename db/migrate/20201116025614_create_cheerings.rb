class CreateCheerings < ActiveRecord::Migration[5.2]
  def change
    create_table :cheerings do |t|
      t.integer :member_id
      t.integer :post_id

      t.timestamps
    end
  end
end
