class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # ありがとうを受け取る側
  has_many :to_thanks, class_name: "Thank", foreign_key: "to_id", dependent: :destroy
  has_many :tos, through: :to_thanks, source: :from
  # ありがとうを贈る側
  has_many :from_thanks, class_name: "Thank", foreign_key: "from_id", dependent: :destroy
  has_many :froms, through: :from_thanks, source: :to

  has_many :praises, dependent: :destroy
  has_many :cheerings, dependent: :destroy

  # 退職memberはログイン出来ない
  def active_for_authentication?
    super && (self.is_delete == false)
  end
end
