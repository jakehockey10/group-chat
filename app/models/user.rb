class User < ApplicationRecord
  include ImageUploader[:image]
  include Appearable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  validates :email, presence: true
  validates :username, presence: true, uniqueness: true
  validates :appearance, presence: true
end
