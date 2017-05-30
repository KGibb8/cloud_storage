class AccountsController < ApplicationController
  before_action :not_found, only: [:show], if: Proc.new { invalid_subdomain? }

  def index
  end

  def create
    account = if current_user
                Account.create_with_current_user(account_params, current_user.id)
              else
                Account.create_with_new_user(account_params, user_params)
              end

    if account.present?
      sign_in account.users.first unless current_user
      redirect_to root_url(subdomain: account.subdomain)
    else
      flash[:errors] = 'account or user could not be created'
      redirect_to root_url(subdomain: 'app')
    end
  end

  def show
  end

  private

  def account_params
    params.require(:account).permit(:email, :subdomain)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
