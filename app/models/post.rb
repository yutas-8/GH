class Post < ApplicationRecord
  belongs_to :member
  attachment :image
end
