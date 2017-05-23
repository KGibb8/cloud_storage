class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def create
    if current_user
      account = Account.create(account_params)
      if account.valid?
        AccountUser.create(account: account, user: current_user)
        redirect_to subdomain: account.subdomain, controller: :accounts, action: :show
      else
        redirect_to accounts_path
      end
    else
      account = Account.create_with_user(account: account_params, user: user_params)
      redirect_to subdomain: account.subdomain, controller: :accounts, action: :show
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
