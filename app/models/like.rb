class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, touch: true
  belongs_to :user
  
  after_create :increment_counters
  after_destroy :decrement_counters

  [:increment, :decrement].each do |type|
    define_method("#{type}_counters") do
      likable_type.classify.constantize.send("#{type}_counter", "likes_count".to_sym, self.likable_id)
    end
  end
end
# likes_countカラムはそれぞれのモデルにつくる
# likes_count  integer  default: 0