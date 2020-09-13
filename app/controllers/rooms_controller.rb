class RoomsController < ApplicationController
  before_action :load_conversation, :authenticate_conversation, only: [:show]
  before_action :set_friend_id, only: [:create]
  before_action :get_friends, only: [:index, :show, :user_autocomplete]

  def index
  end

  # Find or create the conversation
  def create
    @conversation = Room.find_conversation(current_user.id, @friend_id)
    unless @conversation.present?
      @conversation = current_user.rooms.build(friend_id: @friend_id)
      @conversation.save
    end
    redirect_to room_path(@conversation)
  end

  # Show conversation with friend, load all messages
  def show
    @message = RoomMessage.new room: @conversation
    @friend = @conversation.find_friend(current_user)
    @messages = @conversation.room_messages.includes(:user)
  end

  # Search for the friend to start chat
  def user_autocomplete
    @users = @users.order(:username).where("username like ?", "%#{params[:value]}%")
    respond_to do |format|
      format.js
    end
  end

  protected

  def set_friend_id
    @friend_id = params[:user_id]
  end

  # Get all friends
  def get_friends
    @users = User.get_friends(current_user)
  end

  # Load conversation with friend
  def load_conversation
    @conversation = ConversationService.new(params[:id]).call if params[:id]
  end

  # Authenticate users for conversation
  def authenticate_conversation
    unless @conversation.authenticate_user_for_conversation(current_user)
      redirect_to rooms_path
    end
  end
end
