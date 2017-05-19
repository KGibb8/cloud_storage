class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def create
    account = Account.create(account_params)
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(:email, :subdomain)
  end
end
