class Xroom < ApplicationRecord
  belongs_to :user
  has_many :xmessages, dependent: :destroy
end
