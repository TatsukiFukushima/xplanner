class MidTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :long_term_goal_id
  belongs_to :long_term_goal
  belongs_to :user
  has_many :short_term_goals, dependent: :destroy
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
      tmp = MidTermGoal.where(['content LIKE ?', "%#{search}%"])
    else
      tmp = MidTermGoal.all
    end
    tmp = tmp.get_by_status(status) if status.present?
    tmp = tmp.order('likes_count DESC') if like_order.present?
    tmp = tmp.order('comments_count DESC') if comment_order.present?
    return tmp
  end
  
  # いいねランキングのためのメソッド
  def self.m_rank
    MidTermGoal.find(Like.where(likable_type: 'MidTermGoal').group(:likable_id).order('count(likable_id) desc').limit(10).pluck(:likable_id))
  end
  
  # あなたいいねをした中期目標
  def self.your_favorite_m_goals(user_id)
    MidTermGoal.find(Like.where(likable_type: 'MidTermGoal').where(user_id: user_id).order('created_at desc').pluck(:likable_id))
  end 
  
  # フォロワーが更新した中期目標
  def self.followers_updated_m_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    MidTermGoal.where(user_id: following_ids).order('updated_at desc').limit(20)
  end 
  
  # フォロワーが実行中の中期目標
  def self.followers_ongoing_m_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    MidTermGoal.where(user_id: following_ids).where(status: '実行中').order('updated_at desc').limit(20)
  end 
  
  # フォロワーが達成した中期目標
  def self.followers_achieved_m_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    MidTermGoal.where(user_id: following_ids).where(status: '達成済み').order('updated_at desc').limit(20)
  end 
  
  # フォロワーがいいねをした長期目標
  def self.followers_favorite_m_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    MidTermGoal.find(Like.where(likable_type: 'MidTermGoal').where(user_id: following_ids).order('created_at desc').limit(20).pluck(:likable_id))
  end 
end
