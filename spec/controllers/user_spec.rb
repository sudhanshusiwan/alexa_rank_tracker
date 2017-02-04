require 'rails_helper'

describe UsersController do

  describe 'GET #dashboad' do

    it 'should redirect to login page when not logged in' do
      get :dashboard
      expect(response).to redirect_to :action => :new, :controller => 'devise/sessions'
    end

    it 'should render dashboard when logged in' do
      sign_in( FactoryGirl.create(:user), scope: :user )
      get :dashboard
      expect(response).to render_template('users/dashboard')
    end
  end

  describe 'GET #settings' do

    it 'should redirect to login page when not logged in' do
      user =  FactoryGirl.create(:user)
      get :settings, params: { id: user.id }
      expect(response).to redirect_to :action => :new, :controller => 'devise/sessions'
    end

    it 'should render settings when logged in' do
      user =  FactoryGirl.create(:user)
      sign_in user
      get :settings, params: { id: user.id }
      expect(response).to render_template('users/settings')
    end
  end

end
