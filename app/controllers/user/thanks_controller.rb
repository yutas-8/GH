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


  # def reverses
  #   member = Member.find(params[:member_id])
  #   @members = member.reverses
  # end

  # def gives
  #   member = Member.find(params[:member_id])
  #   @members = member.gives
  # end

  private
  def thank_params
    params.require(:thank).permit(:body)
  end
end
