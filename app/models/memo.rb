class Memo < ApplicationRecord
  belongs_to :memoable, polymorphic: true
  validates :content, presence: true
end
