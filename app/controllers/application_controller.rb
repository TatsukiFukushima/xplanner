class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 管理者かどうか確認
  def admin_user 
    redirect_to(root_url) unless current_user.admin? 
  end 
  
# ログイン済みユーザーかどうか確認
  def logged_in_user 
    unless logged_in?
      store_location 
      flash[:danger] = "Please log in."
      redirect_to login_url 
    end 
  end 
  
end
