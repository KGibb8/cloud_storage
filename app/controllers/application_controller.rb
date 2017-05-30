class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Forbidden do |exception|
    @error_message = exception.message
    render :file => 'public/403.html', :status => :forbidden, :layout => false
  end

  rescue_from NotFound do |exception|
    @error_message = exception.message
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

  before_action :current_account, if: :valid_subdomain?
  before_action :authenticate_user!, if: Proc.new { current_user.nil? && valid_subdomain? }

  before_action :current_account_user, if: :user_accessing_subdomain?
  before_action :authenticate_account_user!, if: :user_accessing_subdomain?

  before_action :reset_current_account!, if: :invalid_subdomain?
  before_action :reset_user_account!, if: Proc.new { invalid_subdomain? || current_user.nil? }

  helper_method :current_account
  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end

  def reset_current_account!
    @current_account = nil
  end

  helper_method :current_account_user
  def current_account_user
    @current_account_user ||= AccountUser.find_by(account: current_account, user: current_user)
  end

  def authenticate_account_user!
    not_found unless @current_account_user
  end

  def reset_user_account!
    @current_account_user = nil
  end

  private

  def user_accessing_subdomain?
    current_user.present? && valid_subdomain?
  end

  def valid_subdomain?
    DomainGenerator::SubdomainPresent.private?(request)
  end

  def invalid_subdomain?
    DomainGenerator::SubdomainAbsent.private?(request)
  end

  def forbidden
    raise Forbidden.new, 'Forbidden'
  end

  def not_found
    raise NotFound.new, 'Not Found'
  end
end
