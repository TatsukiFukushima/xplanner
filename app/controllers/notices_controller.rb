class NoticesController < ApplicationController
  def index
    @user = User.find(params[:id])
    @to_user = User.first
    @notices = Notice.where(to_id: params[:id])
  end
end
