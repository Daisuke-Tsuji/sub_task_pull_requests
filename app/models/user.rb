class User < ApplicationRecord
  has_many :postcomments
  has_many :microposts, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id",
                       dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id",
                       dependent: :destroy # フォロワー取得
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user,  through: :followed, source: :follower

  mount_uploader :avatar, AvatarUploader

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :micropost
  def already_liked?(micropost)
    self.likes.exists?(micropost_id: micropost.id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:user_name]
         #:confirmable, :lockable, :timeoutable , :trackable
  validates :full_name, :user_name , presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, allow_blank: true,
                   format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length:{ maximum: 150 },allow_blank: true
  VALID_TELEPHON_REGEX = /\A\d{10,11}\z/
  validates :phone, allow_blank: true,
            format: { with: VALID_TELEPHON_REGEX}
  validates :gender, length: { is: 1 },allow_blank: true


  def email_required?
    false
  end

  def email_changed?
    false
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  def feed
    #Micropost.where("user_id = ?", self.id)
    #Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
    #Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
    #                  following_ids: following_ids, user_id: id)
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

end
