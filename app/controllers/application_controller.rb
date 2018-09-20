class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 管理者かどうか確認
  def admin_user 
    redirect_to(root_url) unless current_user.admin? 
  end 
end
