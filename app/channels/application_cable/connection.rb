module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :warden
    identified_by :current_account

    def connect
      self.current_user = find_verified_user
      self.current_account = find_account_by_domain
      self.warden = env["warden"]
    end

    protected

    def find_verified_user
      verified_user = User.find_by(id: cookies.signed['user.id'])
      verified_user ? verified_user : reject_unauthorized_connection
    end

    def find_account_by_domain
      account = Account.find_by(subdomain: request.subdomain)
      account ? verified_account : reject_unauthorized_connection
    end
  end
end
