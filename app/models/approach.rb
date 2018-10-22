class Approach < ApplicationRecord
  include RankedModel 
  ranks :row_order, with_same: :short_term_goal_id 
  belongs_to :short_term_goal
  has_one :deadline, as: :due_date, dependent: :destroy, inverse_of: :due_date
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_one :memo, as: :memoable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :deadline
  validates :content, presence: true, length: { maximum: 255 }
  validates :effectiveness, presence: true 
  enum effectiveness: { "？": 0, "◎": 1, "〇": 2, "△": 3, "✖": 4 }
  scope :get_by_effectiveness, ->(e) { where(effectiveness: e) }
  
  
  # そのユーザーがそれを「いいね」しているかどうかの確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end 
  
  # 検索機能のためのメソッド
  def self.search(search: nil, effectiveness: nil, like_order: nil, comment_order: nil)
    if search.present?
      tmp = Approach.where(['content LIKE ?', "%#{search}%"])
    else
      tmp = Approach.all
    end
    tmp = tmp.get_by_effectiveness(effectiveness) if effectiveness.present?
    tmp = tmp.order('likes_count DESC') if like_order.present?
    tmp = tmp.order('comments_count DESC') if comment_order.present?
    return tmp
  end
  
  # いいねランキングのためのメソッド
  def self.a_rank
    Approach.find(Like.where(likable_type: 'Approach').group(:likable_id).order('count(likable_id) desc').limit(10).pluck(:likable_id))
  end 
  
  # この目標を作成したユーザーを獲得するメソッド
  def user 
    self.short_term_goal.mid_term_goal.long_term_goal.user 
  end 
end
