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

    def login

        creds = params[:user]
        # 1) check if user exists - lets use a method > check_user
        @user = User.check_user(creds)

        # 2) if I do have that user and the UN and PW check out, then grant token
        if (@user) 
            token = @user.grant_token
            render json: {token: token}  # token.to_json()
        # elsif user doesnt exist "if @user == nil"

        # else "if @user == false"
        end
        # 3) send token to client in a json object

    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end
end
