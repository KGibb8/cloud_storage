class AccountsController < ApplicationController

  def index
  end

  def create
    account = if current_user
                Account.create_with_current_user(account_params, current_user.id)
              else
                Account.create_with_first_user(account_params, user_params)
              end

    if account.present?
      sign_in account.users.first unless current_user
      redirect_to subdomain_path(account)
    else
      flash[:errors] = 'Account or User could not be created'
      redirect_to home_path
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
