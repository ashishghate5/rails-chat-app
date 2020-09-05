module RoomsHelper
  
  def set_float_value room_message
    (room_message.user_id == current_user.id) ? "right" : "left"
  end
end
