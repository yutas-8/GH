class User::MembersController < ApplicationController
  #before_action :current_member, only: [:edit, :update]
  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(current_member)
  end

  private
  def member_params
    params.require(:member).permit(:first_name, :last_name, :birthday, :introduction, :profile_image)
  end

  # 自分のアカウトでしか編集、更新が出来ない
  # def current_member
  #   @member = Member.find(params[:id])
  #   redirect_to(member_path(current_member))unless @member == current_member
  # end
end
