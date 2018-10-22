class Approach < ApplicationRecord
  include RankedModel 
  ranks :row_order, with_same: :short_term_goal_id 
  belongs_to :short_term_goal
  belongs_to :user
  has_one :deadline, as: :due_date, dependent: :destroy, inverse_of: :due_date
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_one :memo, as: :memoable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :deadline
  validates :content, presence: true, length: { maximum: 255 }
  validates :effectiveness, presence: true 
  enum effectiveness: { "？": 0, "◎": 1, "〇": 2, "△": 3, "✖": 4 }
  scope :get_by_effectiveness, ->(e) { where(effectiveness: e) }
  enum status: { "未達成": 0, "実行中": 1, "達成済み": 2 }
  scope :get_by_status, ->(status) { where(status: status) }
  
  
  # そのユーザーがそれを「いいね」しているかどうかの確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end 
  
  # 検索機能のためのメソッド
  def self.search(search: nil, status: nil, effectiveness: nil, like_order: nil, comment_order: nil)
    if search.present?
      tmp = Approach.where(['content LIKE ?', "%#{search}%"])
    else
      tmp = Approach.all
    end
    tmp = tmp.get_by_effectiveness(effectiveness) if effectiveness.present?
    tmp = tmp.get_by_status(status) if status.present?
    tmp = tmp.order('likes_count DESC') if like_order.present?
    tmp = tmp.order('comments_count DESC') if comment_order.present?
    return tmp
  end
  
  # いいねランキングのためのメソッド
  def self.a_rank
    Approach.find(Like.where(likable_type: 'Approach').group(:likable_id).order('count(likable_id) desc').limit(10).pluck(:likable_id))
  end 
  
  # あなたいいねをしたアプローチ
  def self.your_favorite_approaches(user_id)
    Approach.find(Like.where(likable_type: 'Approach').where(user_id: user_id).order('created_at desc').pluck(:likable_id))
  end 
  
  # フォロワーが更新したアプローチ
  def self.followers_updated_approaches(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    Approach.where(user_id: following_ids).order('updated_at desc').limit(20)
  end 
  
  # フォロワーが実行中のアプローチ
  def self.followers_ongoing_approaches(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    Approach.where(user_id: following_ids).where(status: '実行中').order('updated_at desc').limit(20)
  end 
  
  # フォロワーが達成したアプローチ
  def self.followers_achieved_approaches(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    Approach.where(user_id: following_ids).where(status: '達成済み').order('updated_at desc').limit(20)
  end 
  
  # フォロワーがいいねをしたアプローチ
  def self.followers_favorite_approaches(current_user_id)
    following_ids = Relationship.where(follower_id: current_user_id).pluck(:followed_id)
    Approach.find(Like.where(likable_type: 'Approach').where(user_id: following_ids).order('created_at desc').limit(20).pluck(:likable_id))
  end 
end
