class UsersController < ApplicationController
  def dashboard
    @dashboard_chart_data = current_user.get_dashboard_data
  end

  def settings
    @user_websites = current_user.user_websites.includes(:website)
  end
end