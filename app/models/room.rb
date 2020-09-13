class Room < ApplicationRecord

  has_many :room_messages, dependent: :destroy
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :friend, class_name: :User, foreign_key: :friend_id

  scope :sender_receiver_room, -> (sender_id, receiver_id) { where(creator_id: sender_id, friend_id: receiver_id) }
  scope :receiver_sender_room, -> (sender_id, receiver_id) { where(friend_id: sender_id, creator_id: receiver_id) }

  before_create :assign_name

  # Assign name to the conversation(room)
  def assign_name
    friend = User.find self.friend_id
    self.name = friend.username
  end

  # Find conversation with friend
  def self.find_conversation sender_id, receiver_id
    return (sender_receiver_room(sender_id, receiver_id)[0] or receiver_sender_room(sender_id, receiver_id)[0])
  end

  # Find friend for conversation
  def find_friend(current_user)
    return self.creator_id == current_user.id ? self.friend : self.creator
  end

  def authenticate_user_for_conversation current_user
    self.creator_id == current_user.id || self.friend_id == current_user.id
  end
end
