class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def create
    Account.create_with_admin_user(account: account_params, user: user_params)
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(:email, :subdomain)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
