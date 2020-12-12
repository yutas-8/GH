class User::HomeController < ApplicationController
  before_action :authenticate_member!, only: [:top]
  def top
    # ありがとう
    @today_thanks = Thank.where(created_at: Time.zone.now.all_day)
    # 本番環境とローカル環境で使える構文に変換
    if Rails.env.production?
      @birthday_members = Member.
                          where("date_format(ADDTIME(birthday, '09:00:00'), '%m') = '?'", Time.zone.now.month).
                          select(:first_name, :last_name, :birthday, "date_format(ADDTIME(birthday, '09:00:00'), '%d') as day").
                          order("day")
      @next_birthday_members = Member.
                               where("date_format(ADDTIME(birthday, '09:00:00'), '%m') = '?'", Time.zone.now.next_month.month).
                               select(:first_name, :last_name, :birthday, "date_format(ADDTIME(birthday, '09:00:00'), '%d') as day").
                               order("day")
    else
      @birthday_members = Member.
                          where("strftime('%m', datetime(birthday, '+9 hours')) = '?'", Time.zone.now.month).
                          select(:first_name, :last_name, :birthday, "strftime('%d', datetime(birthday, '+9 hours')) as day").
                          order("day")
      @next_birthday_members = Member.
                               where("strftime('%m', datetime(birthday, '+9 hours')) = '?'", Time.zone.now.next_month.month).
                               select(:first_name, :last_name, :birthday, "strftime('%d', datetime(birthday, '+9 hours')) as day").
                               order("day")
    end
    @this_month_thanks = Thank.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
    @prev_month_thanks = Thank.where(created_at: Time.current.prev_month.beginning_of_month..Time.current.prev_month.end_of_month)
    @thanks = Thank.where(to_id: current_member.id).order(created_at: :desc).limit(5)
      # ありがとうのランキング
    @from_thank_ranks = Member.thanks_ranking_given_this_month.limit(3)
    @to_thank_ranks = Member.thanks_ranking_received_this_month.limit(3)
    # 投稿
    @posts = Post.order(created_at: :desc).limit(5)
  end

  def about; end
end
