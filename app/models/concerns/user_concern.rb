module UserConcern
  extend ActiveSupport::Concern

  included do
    validates :username, uniqueness: true, presence: true
    has_many :room_messages, dependent: :destroy
    has_many :rooms, foreign_key: :creator_id
    scope :all_except, ->(user) { where.not(id: user) }
  end
end