class User::ThanksController < ApplicationController

  def index
    @thanks = Thank.all
    @thank = Thank.new


    @members = Member.all
    @member_name_list = {} # hash 連想配列
    @members.each do |member|
      fullname = member.first_name + ' ' + member.last_name # セレクトボックスでfullname表示
      @member_name_list[fullname] = member.id # fullnameとidを紐付ける
    end
  end

  def create
    @member = Member.find(params[:thank][:member_id])
    @thank = current_member.from_thanks.build(thank_params)
    @thank.to_id = @member.id
    @thank.save
    redirect_to thanks_path(current_member)
  end

  def edit
    @thank = Thank.find(params[:id])
    @members = Member.all
    @member_name_list = {}
    @members.each do |member|
      fullname = member.first_name + ' ' + member.last_name
      @member_name_list[fullname] = member.id
    end
  end

  def update
    @thank = Thank.find(params[:id])
    if @thank.to_id == current_member
        @thank.update(thank_params)
        redirect_to thanks_path(current_member)
    else
        redirect_to thanks_path
    end
  end

  def destroy
    @thank = Thank.find(params[:id])
    if @thank.to_id == current_member
        @thank.destroy
        redirect_to thanks_path(current_member)
    end
  end


  def tos
    member = Member.find(params[:member_id])
    @members = member.tos
  end

  def froms
    member = Member.find(params[:member_id])
    @members = member.froms
  end

  private
  def thank_params
    params.require(:thank).permit(:body)
  end
end
