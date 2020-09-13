class ConversationService
  def initialize(room_id)
    @conversation = Room.find(room_id)
  end

  def call
    @conversation
  end
end