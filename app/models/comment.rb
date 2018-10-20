class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  validates :content, presence: true
  has_many :comment_replies, dependent: :destroy
  
  after_create :increment_counters
  after_destroy :decrement_counters

  [:increment, :decrement].each do |type|
    define_method("#{type}_counters") do
      commentable_type.classify.constantize.send("#{type}_counter", "comments_count".to_sym, self.commentable_id)
    end
  end
end
# comments_countカラムはそれぞれのモデルにつくる
# comments_count  integer  default: 0