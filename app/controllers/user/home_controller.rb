class User::HomeController < ApplicationController
  def top
    # ありがとう
    @today_thanks = Thank.where("created_at >= ?", Date.today)
    @this_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.month)
    @prev_month_thanks = Thank.where("cast(strftime('%m', created_at) as int) = ?", Time.now.prev_month.month)
    @month_to_month_thanks = @this_month_thanks.count -  @prev_month_thanks.count
    @thanks = Thank.where(to_id: current_member.id).order(created_at: :desc).limit(5)
    # 誕生日
    @birthday_members = Member.where("cast(strftime('%m', birthday) as int) = ?", Time.now.month)
    @next_birthday_members = Member.where("cast(strftime('%m', birthday) as int) = ?", Time.now.next_month.month)
    # 投稿
    @posts = Post.order(created_at: :desc).limit(5)

  end
end
