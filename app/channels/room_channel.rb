class RoomChannel < ApplicationCable::Channel
  def subscribed
    conversation = Room.find params[:room]
    stream_for conversation
  end
end
