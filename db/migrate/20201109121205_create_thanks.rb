class CreateThanks < ActiveRecord::Migration[5.2]
  def change
    create_table :thanks do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
