class XroomsController < ApplicationController
  before_action :logged_in_user
  before_action :set_xroom, only: [:edit, :update, :show, :destroy]
  
  
  def new 
    @xroom = current_user.xrooms.build
  end 
  
  def create
    @xroom = current_user.xrooms.build(xroom_params)
    if @xroom.save
      flash[:success] = "XRoomを作成しました"
      redirect_to xrooms_path 
    else 
      render 'new'
    end 
  end 
  
  def edit
  end 
  
  def update
    if @xroom.update_attributes(xroom_params)
      @xroom.reload
    else 
      render 'edit'
    end 
  end 
  
  def index 
    @xrooms = Xroom.all
  end 
  
  def show
    @xmessages = @xroom.xmessages
    @xroom_users = @xroom.users
  end
  
  def destroy
    @xroom.destroy
    flash[:success] = "X Roomを削除しました"
    redirect_to xrooms_path
  end 
  
  
  private 
    def xroom_params
      params.require(:xroom).permit(:name, :category, :description)
    end 
    
  # beforeアクション
  
    def set_xroom
      @xroom = Xroom.find(params[:id])
    end 
end
