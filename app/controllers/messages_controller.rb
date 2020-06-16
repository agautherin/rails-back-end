class MessagesController < ApplicationController

    before_action :authorize_request

    def create
       
        message = Message.new( message_text: params[:message][:message_text], chatroom_id: params[:message][:chatroom_id], user_id: @current_user.id, encryption_id: 1)
        if message.save
            chat_room = Chatroom.find(message.chatroom_id)
            ActionCable.server.broadcast(  "chatroom_channel", message )
           else
            render json: {errors: message.errors.full_messages}, status: 400 
        end

    end

    private
    def message_params(*args)
        params.require(:message).permit(*args)
    end


end
