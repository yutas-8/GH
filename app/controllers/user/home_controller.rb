class User::HomeController < ApplicationController
  before_action :authenticate_member!
  def top
    # ありがとう
    @today_thanks = Thank.where("created_at >= ?", Date.today)
    @this_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.month)
    @prev_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.prev_month.month)
    @month_to_month_thanks = @this_month_thanks.count -  @prev_month_thanks.count
    @thanks = Thank.where(to_id: current_member.id).order(created_at: :desc).limit(5)
      #ありがとうのランキング
    @from_thank_ranks = Member.find(@this_month_thanks.group(:from_id).order('count(from_id) desc').limit(3).pluck(:from_id))
    @to_thank_ranks =  Member.find(@this_month_thanks.group(:to_id).order('count(to_id) desc').limit(3).pluck(:to_id))
    # 誕生日
    @birthday_members = Member.where("cast(strftime('%m', birthday) as int) = ?", Time.now.month)
    @next_birthday_members = Member.where("cast(strftime('%m', birthday) as int) = ?", Time.now.next_month.month)
    # 投稿
    @posts = Post.order(created_at: :desc).limit(5)
  end

  def about
  end
end
