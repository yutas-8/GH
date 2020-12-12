class Post < ApplicationRecord
  belongs_to :member
  has_many :post_comments, dependent: :destroy
  has_many :praises, dependent: :destroy
  has_many :cheerings, dependent: :destroy
  attachment :image

  def praised_by?(member)
    praises.where(member_id: member.id).exists?
  end

  def cheering_by?(member)
    cheerings.where(member_id: member.id).exists?
  end

  def self.searches(search)
    if search
      @posts = Post.where("title like?", "%#{search}%")
      @posts = Post.where("body like?", "%#{search}%")
    else
      @posts = Post.all
    end
  end
end
