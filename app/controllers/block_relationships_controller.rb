class BlockRelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @user = User.find(params[:blocked_id])
    current_user.block(@user)
    respond_to do |format|
      format.html { redirect_to user_long_term_goals_path(@user) }
      format.js
    end
  end
  
  def destroy
    @user = BlockRelationship.find(params[:id]).blocked
    current_user.unblock(@user)
    respond_to do |format|
      format.html { redirect_to user_long_term_goals_path(@user) }
      format.js
    end
  end
  
end
