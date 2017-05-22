class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_reader :current_user

  before_action :current_account, if: Proc.new { SubdomainPresent.matches?(request) }
  # before_action :authenticate_user!

  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end
end
