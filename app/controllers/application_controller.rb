class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # devise gem's -- authenticate user before each action
  before_action :authenticate_user!
end
