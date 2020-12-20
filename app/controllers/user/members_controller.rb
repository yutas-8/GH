class User::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_member, only: [:edit, :update]
  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(current_member)
    else
      render :edit
    end
  end

  private

    def member_params
      params.require(:member).permit(:first_name, :last_name, :birthday, :introduction, :profile_image)
    end

    def correct_member
      @member = Member.find(params[:id])
      redirect_to root_path unless @member == current_member
    end
end
