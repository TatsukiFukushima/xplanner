class MidTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :long_term_goal_id
  belongs_to :long_term_goal
  has_many :short_term_goals, dependent: :destroy
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true
  enum status: { "未達成": 0, "実行中": 1, "達成済み": 2 }
end
