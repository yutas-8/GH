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

  def self.thanks_ranking_received_this_month
    # Thank TableをJoinする→今月のrecordにしぼる→to_idでgrouping→memberのすべてのカラムとgroupingされたto_idのcountをselect→to_idのcountの降順にならびかえ
    joins(:to_thanks)
      .merge(Thank.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month))
      .group(:to_id)
      .select("members.*, count(to_id) as count_to")
      .order("count_to DESC")
  end

  # 退職memberはログイン出来ない
  def active_for_authentication?
    super && (self.is_delete == false)
  end
end
