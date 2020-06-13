class GroupsController < ApplicationController

    def index
        render json: Group.all
    end

    def create
        render json: Group.create(group_params)
    end

    
    private
    def group_params
        params.require(:groups).permit(:friender_id, :friendee_id)
    end
end
