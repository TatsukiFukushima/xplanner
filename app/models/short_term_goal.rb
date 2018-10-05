class ShortTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :mid_term_goal_id
  belongs_to :mid_term_goal
  has_many :approaches, dependent: :destroy 
  has_one :deadline, as: :due_date, dependent: :destroy, inverse_of: :due_date
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_one :memo, as: :memoable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :deadline
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true 
  enum status: { "未達成": 0, "実行中": 1, "達成済み": 2 }
  
  
  # そのユーザーがそれを「いいね」しているかどうかの確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end 
end
