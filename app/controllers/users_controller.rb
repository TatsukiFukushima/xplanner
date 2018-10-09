class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :following, :followers, :blocking]
  before_action :correct_user, only: [:edit, :update]
  
  def index 
    @user = current_user
    @users = User.search(params[:search]).paginate(page: params[:page])
  end 
  
  def new
    @user = User.new
  end
  
  # def show
  #   @user = User.find(params[:id])
  #   redirect_to user_long_term_goals_path(@user)
  # end
  
  # メッセージ機能の作成のためにshowを作成。
  def show
    @user = User.find(params[:id])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.resent_in_room(@room_id)
    @users = current_user.following.paginate(page: params[:page])
  end
  
  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "確認用メールを送信しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit 
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_long_term_goals_path(@user)
    else 
      render 'edit'
    end 
  end 
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def blocking
    @title = "blocking"
    @user  = User.find(params[:id])
    @users = @user.blocking.paginate(page: params[:page])
    render 'show_block'
  end
  
  
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end 
end