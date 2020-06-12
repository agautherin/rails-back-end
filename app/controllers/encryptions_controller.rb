class EncryptionsController < ApplicationController

    def index
        render json: Encryption.all
    end
end
