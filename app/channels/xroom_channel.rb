class XroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "xroom_channel_#{params['xroom_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Xmessage.create!(content: data['xmessage'], user_id: current_user.id, xroom_id: params['xroom_id'])
  end
end
