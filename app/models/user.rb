class User < ApplicationRecord
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
end
