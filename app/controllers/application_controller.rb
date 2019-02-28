class ApplicationController < ActionController::Base
  private
    def check_if_user_is_admin
      redirect_to root_path unless current_user.is_admin?
    end
end
