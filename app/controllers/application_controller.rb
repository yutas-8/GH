class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_image_id, :introduction, :birthday])
    end

  # ログイン後の遷移するページ管理者と分ける
    def after_sign_in_path_for(resource)
      if resource.instance_of?(Admin)
        admin_members_path
      elsif resource.instance_of?(Member)
        root_path
      end
    end

  # ログアウト後の遷移するページ管理者と分ける
    def after_sign_out_path_for(resource)
      if resource == :admin
        new_admin_session_path
      elsif resource == :member
        new_member_session_path
      end
    end
end
