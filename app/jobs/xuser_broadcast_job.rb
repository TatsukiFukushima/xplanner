class XuserBroadcastJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    # ActionCable.server.broadcast "xroom_channel_#{subscription.xroom_id}",
    #   xroom_user: render_xroom_user(subscription)
    ActionCable.server.broadcast "xroom_channel_#{subscription.xroom_id}",
      xuser_count: render_xuser_count(subscription),
      xusers: render_xroom_user
  end
  
  
  private
    
    def render_xuser_count(subscription)
      Subscription.where(xroom_id: subscription.xroom_id).count
    end
    
    def render_xroom_user
      ApplicationController.renderer.render(partial: 'xrooms/xroom_user')
    end 
end
