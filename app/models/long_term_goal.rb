class LongTermGoal < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :user_id 
  belongs_to :user
  has_many :mid_term_goals, dependent: :destroy
  has_one :deadline, as: :due_date, dependent: :destroy, inverse_of: :due_date
  has_many :likes, as: :likable, dependent: :destroy#, inverse_of: :likable
  has_one :memo, as: :memoable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :deadline
  validates :category, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true 
  enum status: { "未達成": 0, "実行中": 1, "達成済み": 2 }
  # ステータスによる絞り込み
  scope :get_by_status, ->(status) { where(status: status) }
  
  
  # そのユーザーがそれを「いいね」しているかどうかの確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end 
  
  # 検索機能のためのメソッド
  def self.search(search: nil, category_kwd: nil, status: nil, like_order: nil, comment_order: nil)
    if search.present?
      tmp = LongTermGoal.where(['content LIKE ?', "%#{search}%"])
    else
      tmp = LongTermGoal.all
    end
    tmp = tmp.where(['category LIKE ?', "%#{category_kwd}%"])
    tmp = tmp.get_by_status(status) if status.present?
    tmp = tmp.order('likes_count DESC') if like_order.present?
    tmp = tmp.order('comments_count DESC') if comment_order.present?
    return tmp
  end
  
  # いいねランキングのためのメソッド
  def self.l_rank
    LongTermGoal.find(Like.where(likable_type: 'LongTermGoal').group(:likable_id).order('count(likable_id) desc').limit(10).pluck(:likable_id))
  end 
  
  # あなたがいいねをした長期目標
  def self.your_favorite_l_goals(user_id)
    LongTermGoal.find(Like.where(likable_type: 'LongTermGoal').where(user_id: user_id).order('created_at desc').pluck(:likable_id))
  end 
  
  # フォロワーが更新した長期目標
  def self.followers_updated_l_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    LongTermGoal.where(user_id: following_ids).order('updated_at desc').limit(20)
  end 
  
  # フォロワーが実行中の長期目標
  def self.followers_ongoing_l_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    LongTermGoal.where(user_id: following_ids).where(status: '実行中').order('updated_at desc').limit(20)
  end 
  
  # フォロワーが達成した長期目標
  def self.followers_achieved_l_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    LongTermGoal.where(user_id: following_ids).where(status: '達成済み').order('updated_at desc').limit(20)
  end 
  
  # フォロワーがいいねをした長期目標
  def self.followers_favorite_l_goals(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    LongTermGoal.find(Like.where(likable_type: 'LongTermGoal').where(user_id: following_ids).order('created_at desc').limit(20).pluck(:likable_id))
  end 
end
