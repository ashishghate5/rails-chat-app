class RoomMessagesController < ApplicationController
  before_action :load_entities, :check_empty_message

  def create
    @room_message = current_user.room_messages.build(room: @room, message: params.dig(:room_message, :message))
    if @room_message.save
      RoomChannel.broadcast_to @room, @room_message
    else
      redirect_to room_path(@room)
    end
  end

  protected

  def check_empty_message
    if params.dig(:room_message, :message) == ""
      redirect_to room_path(@room)
    end
  end

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
