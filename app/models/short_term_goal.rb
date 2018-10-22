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
  scope :get_by_status, ->(status) { where(status: status) }
  
  
  # そのユーザーがそれを「いいね」しているかどうかの確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end 
  
  # 検索機能のためのメソッド
  def self.search(search: nil, status: nil, like_order: nil, comment_order: nil)
    if search.present?
      tmp = ShortTermGoal.where(['content LIKE ?', "%#{search}%"])
    else
      tmp = ShortTermGoal.all
    end
    tmp = tmp.get_by_status(status) if status.present?
    tmp = tmp.order('likes_count DESC') if like_order.present?
    tmp = tmp.order('comments_count DESC') if comment_order.present?
    return tmp
  end
  
  # いいねランキングのためのメソッド
  def self.s_rank
    ShortTermGoal.find(Like.where(likable_type: 'ShortTermGoal').group(:likable_id).order('count(likable_id) desc').limit(10).pluck(:likable_id))
  end 
  
  # この目標を作成したユーザーを獲得するメソッド
  def user 
    self.mid_term_goal.long_term_goal.user 
  end 
end
