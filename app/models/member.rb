class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :posts#dependent: :destroyを外しておく。memberが消えてもpostは残るようにしたいと考えている為
  has_many :post_comments

  #ありがとうを受け取る側
  has_many :to_thanks, class_name: "Thank", foreign_key: "to_id"
  has_many :froms, through: :to_thanks, source: :from
  #ありがとうを贈る側
  has_many :from_thanks, class_name: "Thank", foreign_key: "from_id"
  has_many :tos, through: :from_thanks, source: :to

end
