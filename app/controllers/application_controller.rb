require "#{Rails.root}/app/lib/subdomain_matcher"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_account, if: Proc.new { SubdomainPresent.matches?(request) }
  before_action :reset_current_account, if: Proc.new { SubdomainAbsent.matches?(request) }

  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end

  def reset_current_account
    @current_account = nil
  end

  def authenticate_user_account!
    @current_account_user ||= AccountUser.find_by(account: current_account, user: current_user)
  end

end
