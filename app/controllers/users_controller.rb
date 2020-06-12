class UsersController < ApplicationController

    def index
        render json: User.all
    end

    def show
        User.find(params[:id])
    end

    def create
        
    end

    def update

    end
end
