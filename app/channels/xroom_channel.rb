class XroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "xroom_channel_#{params['xroom_id']}"
    Subscription.create!(user_id: current_user.id, xroom_id: params['xroom_id'])
  end

  def unsubscribed
    subscription = Subscription.find_by(user_id: current_user.id, xroom_id: params['xroom_id'])
    subscription.destroy
  end

  def speak(data)
    Xmessage.create!(content: data['xmessage'], user_id: current_user.id, xroom_id: params['xroom_id'])
  end
end
