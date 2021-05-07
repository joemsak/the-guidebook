require 'rails_helper'

RSpec.describe "/admin/coaches", type: :request do
  let(:valid_attributes) { attributes_for(:coach) }
  let(:invalid_attributes) { attributes_for(:coach, email: 'invalid') }

  let(:coach) { create(:coach) }

  before { sign_in(:admin) }

  describe "GET /index" do
    it "renders a successful response" do
      create(:coach)
      get admin_coaches_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get admin_coaches_url(coach)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_coach_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_admin_coach_url(coach)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Coach" do
        expect {
          post admin_coaches_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1).and change(CoachProfile, :count).by(1)
      end

      it "redirects to the created coach" do
        post admin_coaches_url, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_coach_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Coach" do
        expect {
          post admin_coaches_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0).and change(CoachProfile, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_coaches_url, params: { user: invalid_attributes }
        expect(response.status).to eq(422)
        expect(response).to render_template('admin/coaches/new')
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { email: "changed@email.com" }
      }

      it "updates the requested coach" do
        expect {
          patch admin_coach_url(coach), params: { user: new_attributes }
        }.to change {
          coach.reload.email
        }.to("changed@email.com")
      end

      it "redirects to the coach" do
        patch admin_coach_url(coach), params: { user: new_attributes }
        coach.reload
        expect(response).to redirect_to(admin_coach_url(coach))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_coach_url(coach), params: { user: invalid_attributes }
        expect(response.status).to eq(422)
        expect(response).to render_template('admin/coaches/edit')
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:coach) { create(:coach) }

    it "destroys the requested coach" do
      expect {
        delete admin_coach_url(coach)
      }.to change(User, :count).by(-1).and change(CoachProfile, :count).by(-1)
    end

    it "redirects to the coaches list" do
      delete admin_coach_url(coach)
      expect(response).to redirect_to(admin_coaches_url)
    end
  end
end
