class Room < ApplicationRecord
  include RoomConcern

  def assign_name
    friend = User.find self.friend_id
    self.name = friend.username
  end

  def self.between sender_id, receiver_id
    return (between1(sender_id, receiver_id)[0] or between2(sender_id, receiver_id)[0])
  end

  def find_friend(current_user)
    return self.creator_id == current_user.id ? self.friend : self.creator
  end

  def authenticate_room_user current_user
    self.creator_id == current_user.id || self.friend_id == current_user.id
  end
end
