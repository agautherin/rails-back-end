class ChatroomsController < ApplicationController

    def index 
        render json: Chatroom.all
    end

    def create
        chat_room = Chatroom.new(chat_room_params)
        if chat_room.save
            render json: chat_room
        else
            render json: {errors: chat_room.errors.full_messages},
            status: 400
        end
    end

    def show
        chat_room = Chatroom.find(params[:id])
        render json: chat_room, include: [:messages]
    end

    private

    def chat_room_params
        params.require(:chatroom).permit(:user_id)
    end


end
