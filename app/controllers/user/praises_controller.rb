class User::PraisesController < ApplicationController
  before_action :authenticate_member!
  def create
    @post = Post.find(params[:post_id])
    @praise = @post.praises.create(member_id: current_member.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @praise = @post.praises.find_by(member_id: current_member.id).destroy
  end
end
