class LongTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :user_id 
  belongs_to :user
  has_many :mid_term_goals, dependent: :destroy
  validates :category, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }

end
