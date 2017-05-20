class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_reader :current_user
end
