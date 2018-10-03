class Approach < ApplicationRecord
  include RankedModel 
  ranks :row_order, with_same: :short_term_goal_id 
  belongs_to :short_term_goal
  has_one :deadline, as: :due_date, dependent: :destroy, inverse_of: :due_date
  has_one :memo, as: :memoable, dependent: :destroy
  accepts_nested_attributes_for :deadline
  validates :content, presence: true, length: { maximum: 255 }
  validates :effectiveness, presence: true 
  enum effectiveness: { "？": 0, "◎": 1, "〇": 2, "△": 3, "✖": 4 }
end
