class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    from_user = User.find_by(id: data['from_id'].to_s)
    to_user = User.find_by(id: data['to_id'].to_s)
    from_user.send_notice(to_user, data['content'])
  end
end
