require "#{Rails.root}/app/lib/subdomain_matcher"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_account, if: :valid_subdomain?
  before_action :authenticate_user!, if: Proc.new { current_user.nil? && valid_subdomain? }
  before_action :authenticate_user_account!, if: Proc.new { current_user.present? && valid_subdomain? }

  before_action :reset_current_account!, if: :invalid_subdomain?
  before_action :reset_user_account!, if: Proc.new { invalid_subdomain? || current_user.nil? }

  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end

  def reset_current_account!
    @current_account = nil
  end

  def authenticate_user_account!
    @current_account_user ||= AccountUser.find_by(account: current_account, user: current_user)
    not_found if @current_account_user.nil?
  end

  def reset_user_account!
    @current_account_user = nil
  end

  private

  def valid_subdomain?
    SubdomainPresent.matches?(request)
  end

  def invalid_subdomain?
    SubdomainAbsent.matches?(request)
  end

  def not_found
    render :file => 'public/403.html', :status => :forbidden, :layout => false
  end
end
