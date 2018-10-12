class XroomsController < ApplicationController
  
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
  
  def index 
    @xrooms = Xroom.all
  end 
  
  def show
    @xroom = Xroom.find(params[:id])
    @xmessages = @xroom.xmessages
  end
  
  
  private 
    def xroom_params
      params.require(:xroom).permit(:category, :description)
    end 
end
