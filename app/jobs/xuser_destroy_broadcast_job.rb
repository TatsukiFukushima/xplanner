class XuserDestroyBroadcastJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    ActionCable.server.broadcast "xroom_channel_#{subscription.xroom_id}",
      xuser_count: render_xuser_count(subscription),
      xusers: render_xroom_user(subscription)
  end
  
  
  private
    
    def render_xuser_count(subscription)
      Subscription.where(xroom_id: subscription.xroom_id).where.not(user_id: subscription.user_id).count
    end
    
    def render_xroom_user(subscription)
      ApplicationController.renderer.render(partial: 'xrooms/xroom_user',
                                          locals: { xroom_users: xusers(subscription) })
    end 
    
    def xusers(subscription)
      subscriptions = Subscription.where(xroom_id: subscription.xroom_id).where.not(user_id: subscription.user_id)
      subscriptions.map {|s| s.user}
    end
end
