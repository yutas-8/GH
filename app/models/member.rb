class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
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
    joins(:to_thanks) # Thank TableをJoinする
      .merge(Thank.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)) # 今月のrecordにしぼる
      .group(:to_id) # to_idでgrouping
      .select("members.*, count(to_id) as count_to") # memberのすべてのカラムとgroupingされたto_idのcountをselect
      .order("count_to DESC") # to_idのcountの降順にならびかえ
  end

  def self.thanks_ranking_given_this_month
    joins(:from_thanks)
      .merge(Thank.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month))
      .group(:from_id)
      .select("members.*, count(from_id) as count_from")
      .order("count_from DESC")
  end

  ##
  # API name : active_for_authentication
  # argument : none
  # return : none
  # detail process : check for removed users
  # 退職memberはログイン出来ない
  def active_for_authentication?
    super && (self.is_delete == false)
  end

  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :encrypted_password, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
