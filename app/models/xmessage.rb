class Xmessage < ApplicationRecord
  belongs_to :user
  belongs_to :xroom 
  validates :content, presence: true
  after_create_commit {XmessageBroadcastJob.perform_later self}
end
