class XmessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(xmessage)
    ActionCable.server.broadcast 'xroom_channel', xmessage:
      render_xmessage(xmessage)
  end 
  
  
  private 
  
    def render_xmessage(xmessage)
      ApplicationController.renderer.render(partial: 'xmessages/xmessage',
                                          locals: { xmessage: xmessage })
    end 
end
