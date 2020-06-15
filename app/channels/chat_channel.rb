class ChatChannel < ApplicationCable::Channel
    def subscribed
        if params[:chatroom_id].present?
            stream_from("Chatroom-#{params[:chatroom_id]}")
        end
    end

    def chat(message_data)

        sender = get_sender(message_data[:user_id])
        chatroom_id = message_data[:chatroom_id]
        message = message_data[:message_text]

        raise 'There was no room specified' if chatroom_id.blank?
        chatroom = get_chatroom(chatroom_id) # A conversation is a room
        raise 'No conversation found!' if chatroom.blank?
        raise 'No message!' if message.blank?

        chatroom.users << sender unless chatroom.users.include?(sender)

        Message.create(
            message_text: message,
            chatroom_id: chatroom,
            user_id: sender,
            encryption_id: 1
          )
    end

    def get_sender(id)
        User.find(id)
    end

    def get_chatroom(id)
        Chatroom.find(id)
    end



end