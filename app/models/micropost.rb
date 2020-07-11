class Micropost < ApplicationRecord
  has_many :postcomments
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :comment, length: { maximum: 2200 }
  validates :image,   presence: true

  def self.search(search)
      return Micropost.all unless search
      Micropost.where(['comment LIKE ?', "%#{search}%"])
  end
end
