module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
      # identify caller, expects that a successful authentication sets an encrypted cookie with User ID
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        # identify caller
        
        verified_user = authorize_request
        
        # what does varified_user REALLY return
        if verified_user
          return verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
