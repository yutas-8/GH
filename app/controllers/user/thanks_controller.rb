class User::ThanksController < ApplicationController
  before_action :authenticate_member!

  def index
    @thanks = Thank.page(params[:page]).reverse_order
    @thank = Thank.new
    @today_thanks = Thank.where("created_at >= ?", Date.today)
    @this_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.month)
    @prev_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.prev_month.month)
    @month_to_month_thanks = @this_month_thanks.count -  @prev_month_thanks.count

    @members = Member.all
    @member_name_list = {} # hash 連想配列
    @members.each do |member|
      fullname = member.first_name + ' ' + member.last_name # セレクトボックスでfullname表示
      @member_name_list[fullname] = member.id # fullnameとidを紐付ける
    end
  end

  def create
    @member = Member.find(params[:thank][:member_id])
    @thank = current_member.from_thanks.new(thank_params)
    @thank.to_id = @member.id
    if @thank.from_id == @thank.to_id#自分にありがとうを送れないようにする
      redirect_to "/"
    else
      @thank.save
      redirect_to thanks_path(current_member)
    end
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
    if @thank.from_id == current_member.id
        @thank.update(thank_params)
        redirect_to thanks_path(current_member)
    else
        redirect_to thanks_path
    end
  end

  def destroy
    @thank = Thank.find(params[:id])
    if @thank.from_id == current_member.id
        @thank.destroy
        redirect_to thanks_path(current_member)
    end
  end


  def tos
    @thanks = Thank.where(to_id: current_member.id).page(params[:page]).reverse_order
  end

  def froms
    @thanks = Thank.where(from_id: current_member.id).page(params[:page]).reverse_order
  end

  private
  def thank_params
    params.require(:thank).permit(:body)
  end
end
