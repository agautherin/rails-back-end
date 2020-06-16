class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    payload = {
      chatroom_id: message.chatroom.id,
      message_text: message.message_text,
      user_id: message.user,
      participants: message.chatroom.users.map(&:id)
    }
    ActionCable.server.broadcast(build_room_id(message.chatroom.id), payload) 
  end

  def build_room_id(id)
    "#{id}"
  end
end
