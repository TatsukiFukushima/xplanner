class NoticeBroadcastJob < ApplicationJob
  def perform(notice)
  ActionCable.server.broadcast "notification_channel_#{notice.to_id}",
                               notice: render_notice(notice)
  end
  
  private
  
    def render_notice(notice)
      ApplicationController.renderer.render(partial: 'notices/notice',
                                          locals: {notice: notice})
    end
end
