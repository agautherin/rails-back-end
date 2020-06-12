class UsersController < ApplicationController

    def index
        render json: User.all
    end

    def show
        User.find(params[:id])
    end

    def create
        render json: User.create(user_params)
    end

    def update

    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end
end
