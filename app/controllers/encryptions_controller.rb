class EncryptionsController < ApplicationController

    before_action :authorize_request

    def index
        render json: Encryption.all
    end

    def create
        
        encrypt = Encryption.new(encrypt_type: params[:type], key: params[:key] )
        if encrypt.save
            #do stuff
            encrypted_message = Encryption.encrypt(params[:type], params[:message], params[:key])
            
            render json: {encr_obj: encrypt, user_id: @current_user, message: encrypted_message}
        else
            render json: {errors: encrypt.errors.full_messages},
            status: 400
        end
    end

    def decrypt
        
        decrypted_message = Encryption.decrypt(params[:type], params[:message], params[:key])
        if decrypted_message
            render json: {user_id: @current_user, message: decrypted_message}
        else 
            render json: {error: true, message: "Error decrypting"}
        end
    end



end
