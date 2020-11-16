class User::CheeringsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @praise = @post.cheerings.create(member_id: current_member.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @praise = @post.cheerings.find_by(member_id: current_member.id).destroy
  end
end
