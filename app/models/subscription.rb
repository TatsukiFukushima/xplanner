class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :xroom
  validates_uniqueness_of :user_id, :scope => :xroom_id
  after_create_commit { XuserBroadcastJob.perform_later self }
  after_destroy_commit { XuserBroadcastJob.perform_later self }
end
