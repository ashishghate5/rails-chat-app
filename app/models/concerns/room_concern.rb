module RoomConcern
  extend ActiveSupport::Concern

  included do
    has_many :room_messages, dependent: :destroy, inverse_of: :room
    belongs_to :creator, class_name: :User, foreign_key: :creator_id
    belongs_to :friend, class_name: :User, foreign_key: :friend_id

    scope :between1, -> (sender_id, receiver_id) { where(creator_id: sender_id, friend_id: receiver_id) }
    scope :between2, -> (sender_id, receiver_id) { where(friend_id: sender_id, creator_id: receiver_id) }

    before_create :assign_name
  end
end