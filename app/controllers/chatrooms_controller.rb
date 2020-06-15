class ChatroomsController < ApplicationController
    before_action :authorize_request

    def index 
        render json: Chatroom.all
    end

    def create
        # byebug
        chat_room = Chatroom.new(user_id: @current_user.id)
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

    def chat_room_params(*args)
        params.require(:chatroom).permit(*args)
    end


end
