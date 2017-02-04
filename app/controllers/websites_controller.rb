class WebsitesController < ApplicationController

  def create_or_update
    params_hash = params.delete(:data)
    current_user.create_or_update_websites( params_hash.values )

    @user_websites = current_user.user_websites.includes(:website)
    render json: { status: 'success', html: render_to_string('/_tracked_websites_form', :layout => false, :locals => { :user_websites => @user_websites })  }
  end

end