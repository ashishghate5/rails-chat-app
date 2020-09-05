class RoomsController < ApplicationController
  before_action :load_room, :authenticate_room_user, only: [:show]
  before_action :get_friend_id, only: [:create]
  before_action :get_friends_list, only: [:index, :show, :user_autocomplete]

  def index
  end

  def create
    @room = Room.between(current_user.id, @friend_id)
    unless @room.present?
      @room = current_user.rooms.build(friend_id: @friend_id)
      @room.save
    end
    redirect_to room_path(@room)
  end

  def show
    @room_message = RoomMessage.new room: @room
    @friend = @room.find_friend(current_user)
    @room_messages = @room.room_messages.includes(:user)
  end

  def user_autocomplete
    @users = @users.order(:username).where("username like ?", "%#{params[:value]}%")
    respond_to do |format|
      format.js
    end
  end

  protected

  def get_friend_id
    @friend_id = params[:user_id]
  end

  def get_friends_list
    @users = FriendsListService.new(current_user).call
  end

  def load_room
    @room = Room.find(params[:id]) if params[:id]
  end

  def authenticate_room_user
    unless @room.authenticate_room_user(current_user)
      redirect_to rooms_path
    end
  end
end
