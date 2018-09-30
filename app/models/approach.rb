class Approach < ApplicationRecord
  include RankedModel 
  ranks :row_order, with_same: :short_term_goal_id 
  belongs_to :short_term_goal
  validates :content, presence: true, length: { maximum: 255 }
  validates :effectiveness, presence: true 
  enum effectiveness: { "ー": 0, "◎": 1, "〇": 2, "△": 3, "✖": 4 }
end
