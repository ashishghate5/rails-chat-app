class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true
  has_many :room_messages, dependent: :destroy
  has_many :rooms, foreign_key: :creator_id
  scope :get_friends, ->(user) { where.not(id: user) }

end
