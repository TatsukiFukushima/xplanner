class Xroom < ApplicationRecord
  belongs_to :user
  has_many :xmessages, dependent: :destroy
  validates :category, presence: true
  validates :description, presence: true
end
