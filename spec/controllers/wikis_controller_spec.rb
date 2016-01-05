require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  #let(:user) {create(:user)}
  let(:wiki) {create(:wiki)}
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: wiki.id
      expect(response).to have_http_status(:success)
    end

    it "renders show view" do
      get :show, id: wiki.id 
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: wiki.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit view" do
      get :edit, id: wiki.id
      expect(response).to render_template :edit
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders new view" do
      get :new
      expect(response).to render_template :new
    end
  end

end
