class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def member_params
    params.require(:member).permit(:is_delete)
  end
end
