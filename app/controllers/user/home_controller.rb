class User::HomeController < ApplicationController
  before_action :authenticate_member!, only: [:top]
  def top
    # ありがとうの件数
    @today_thanks = Thank.where(created_at: Time.zone.now.all_day)
    @this_month_thanks = Thank.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
    @prev_month_thanks = Thank.where(created_at: Time.current.prev_month.beginning_of_month..Time.current.prev_month.end_of_month)
    # 本番環境とローカル環境で使える構文に変換
    birthday_month = "strftime('%m', datetime(birthday, '+9 hours')) = ?"
    column_day = "strftime('%d', datetime(birthday, '+9 hours')) as day"
    if Rails.env.production?
      birthday_month = "date_format(ADDTIME(birthday, '09:00:00'), '%m') = ?"
      column_day = "date_format(ADDTIME(birthday, '09:00:00'), '%d') as day"
    end
    @birthday_members = Member.
                        where(birthday_month, Time.zone.now.month.to_s.rjust(2, "0")).
                        select(:first_name, :last_name, :birthday, column_day).
                        order("day")
    @next_birthday_members = Member.
                             where(birthday_month, Time.zone.now.next_month.month.to_s.rjust(2, "0")).
                             select(:first_name, :last_name, :birthday, column_day).
                             order("day")
    @thanks = Thank.where(to_id: current_member.id).order(created_at: :desc).limit(5)
      # ありがとうのランキング
    @from_thank_ranks = Member.thanks_ranking_given_this_month.limit(3)
    @to_thank_ranks = Member.thanks_ranking_received_this_month.limit(3)
    # 投稿
    @posts = Post.order(created_at: :desc).limit(5)
  end

  def about; end
end
