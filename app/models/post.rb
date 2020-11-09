class Post < ApplicationRecord
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  attachment :image
end
