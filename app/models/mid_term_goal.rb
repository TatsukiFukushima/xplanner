class MidTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :long_term_goal_id
  belongs_to :long_term_goal
  validates :content, presence: true, length: { maximum: 255 }
  
end
