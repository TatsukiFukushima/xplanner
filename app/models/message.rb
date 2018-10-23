class Message < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  after_commit :create_notice
  
  # scope
  default_scope -> {order(created_at: :asc)}
  
  # validations
  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
  
  
  # methods
  def Message.resent_in_room(room_id)
    where(room_id: room_id).last(500)
  end
  
  def create_notice
    @user = User.find(self.from_id)
    notice = Notice.new(to_id: self.to_id, from_id: self.from_id,
              content: "#{@user.name}さんがあなたにメッセージを送信しました", link_to: "/messages/#{self.from_id}")
    notice.save
  end
  
  # Callbacks
  after_create_commit { MessageBroadcastJob.perform_later self }
end
