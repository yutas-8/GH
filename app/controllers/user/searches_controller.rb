class User::SearchesController < ApplicationController
  def search
    @posts = Post.searches(params[:search])
  end
end
