module RoomMessageConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :room, inverse_of: :room_messages
    belongs_to :user
  end
end