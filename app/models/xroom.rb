class Xroom < ApplicationRecord
  belongs_to :user
  has_many :xmessages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  validates :category, presence: true
  validates :description, presence: true
  
  def user_count
    Subscription.where(xroom_id: self.id).count
  end
end
