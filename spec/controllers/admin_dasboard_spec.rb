require 'rails_helper'

describe Admin::DashboardController do

  describe 'GET #index' do

    it 'should redirect to login page when not logged in' do
      get :index
      expect(response).to redirect_to :action => :new, :controller => 'devise/sessions'
    end

    it 'should redirect to user dashboard when logged in as user' do
      sign_in( FactoryGirl.create(:user), scope: :user )
      get :index
      expect(response).to redirect_to root_path
    end

    it 'should render index when logged in as admin' do
      sign_in( FactoryGirl.create(:admin_user), scope: :user )
      get :index
      expect(response).to render_template :index
    end

  end

end