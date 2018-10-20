class Xroom < ApplicationRecord
  belongs_to :user
  has_many :xmessages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  validates :category, presence: true
  validates :description, presence: true
  # 新規XRoom作成時のメッセージ作成
  after_create_commit do
    self.xmessages.create(user_id: self.user_id, content: '新規XRoomを作成しました。')
  end
  
  def user_count
    Subscription.where(xroom_id: self.id).count
  end
  
  
  # 検索機能のためのメソッド
  def self.search(search: nil, x_attr: nil, order: nil)
    if search.present?
      case x_attr
      when 'name'
        tmp = Xroom.where(['name LIKE ?', "%#{search}%"])
      when 'category'
        tmp = Xroom.where(['category LIKE ?', "%#{search}%"]) 
      when 'description'
        tmp = Xroom.where(['description LIKE ?', "%#{search}%"])
      end 
    else
      tmp = Xroom.all
    end
    if order == 'asc'
      tmp = tmp.sort { |a, b| a.subscriptions.count <=> b.subscriptions.count }
    elsif order == 'desc' 
      tmp = tmp.sort { |a, b| b.subscriptions.count <=> a.subscriptions.count }
    end
    return tmp
  end
  
end
