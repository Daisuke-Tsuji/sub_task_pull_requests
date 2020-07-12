class Postcomment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, length: { maximum: 150 }
end
