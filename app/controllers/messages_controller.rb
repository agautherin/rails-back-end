class MessagesController < ApplicationController

    def create
        # header for Authorization token .... decode... get username
        message = Message.new(message_params)
        if message.save
            render json: message
        else
            render json: {errors: message.errors.full_messages}, status: 400 
        end

    end

    private
    def message_params
        params.require(:message).permit(:message_text, :chatroom_id)
    end


end
