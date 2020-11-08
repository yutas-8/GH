class RemoveImageFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :image_, :string
  end
end
