class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def create
    if current_user
      account = Account.create(account_params)
      if account.valid?
        AccountUser.create(account: account, user: current_user)
        redirect_to root_url(subdomain: account.subdomain)
      else
        redirect_to accounts_path
      end
    else
      account_with_user = Account.create_with_user(account: account_params, user: user_params)
      user = account_with_user[:user]
      account = account_with_user[:account]
      unless account.nil?
        sign_in user
        user = warden.authenticate(scope: :user)
        cookies.signed['user.id'] = user.id
        redirect_to root_url(subdomain: account.subdomain)
      else
        flash[:errors] = 'Account or User could not be created'
        redirect_to root_path
      end
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
