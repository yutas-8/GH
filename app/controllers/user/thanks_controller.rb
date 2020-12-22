class User::ThanksController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_member, only: [:edit, :update]
  before_action :member_name_list, only: [:index, :create, :edit, :update]

  def index
    @thanks = Thank.page(params[:page]).reverse_order
    @thank = Thank.new
  end

  def create
    @thank = current_member.from_thanks.new(thank_params)
    if @thank.save
      redirect_to thanks_path(current_member), notice: "ありがとうを贈りました^^"
    else
      flash.now[:alert] = "投稿失敗しました。"
      @thanks = Thank.page(params[:page]).reverse_order
      render :index
    end
  end

  def edit
    @thank = Thank.find(params[:id])
  end

  def update
    @thank = Thank.find(params[:id])
    if @thank.update(thank_params)
      redirect_to thanks_path, notice: "更新しました。"
    else
      flash.now[:alert] = "更新失敗しました。"
      render :edit
    end
  end

  def destroy
    @thank = Thank.find(params[:id])
    return unless @thank.from_id == current_member.id

    if @thank.destroy
      redirect_to thanks_path(current_member), notice: "削除しました。"
    else
      flash.now[:alert] = "削除できませんでした。"
      render :index
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
      params.require(:thank).permit(:body, :to_id)
    end

    def correct_member
      @thank = Thank.find(params[:id])
      redirect_to thanks_path unless @thank.from == current_member
    end

    def member_name_list
      @members = Member.all
      @member_name_list = {}
      @members.each do |member|
        fullname = "#{member.first_name} #{member.last_name}"
        @member_name_list[fullname] = member.id
      end
    end
end
