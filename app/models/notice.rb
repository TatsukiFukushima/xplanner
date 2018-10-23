class Notice < ApplicationRecord
  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"
  
  # Scopes
  default_scope -> {order(created_at: :desc)}

  # Validations
  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :content, presence: true
  
  # Callbacks
  after_create_commit { NoticeBroadcastJob.perform_later self }
end
