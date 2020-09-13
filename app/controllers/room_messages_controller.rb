class RoomMessagesController < ApplicationController
  before_action :load_conversation, :check_empty_message

  # Create the message in conversation and broadcast that into conversation
  def create
    @message = current_user.room_messages.build(room: @conversation, message: params[:room_message][:message])
    if @message.save
      RoomChannel.broadcast_to @conversation, @message
    else
      redirect_to room_path(@conversation)
    end
  end

  protected

  # If message is empty then prevent to send
  def check_empty_message
    if params[:room_message][:message].empty?
      redirect_to room_path(@conversation)
    end
  end

  # load conversation by calling service
  def load_conversation
    @conversation = ConversationService.new(params[:room_message][:room_id]).call if params[:room_message][:room_id].present?
  end
end
