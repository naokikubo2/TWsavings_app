require 'rails_helper'
RSpec.describe "UndoneActions", type: :request do

  before {
    timestamp!
    log_in
  }

  #new
  describe "GET /undone_actions/new" do
    it "render to new page" do
      get new_undone_action_path
      expect(response.status).to eq(200)
    end
  end

  #edit
  describe "GET /undone_actions/:id/edit" do
    context 'other users undone_action page' do
      it "redirect to root page" do
        undone_action = create(:undone_action)
        get edit_undone_action_path(undone_action)
        expect(response).to redirect_to(root_url)
      end
    end
    context 'own blog page' do
      it "render to edit page" do
        undone_action = create(:undone_action, user: current_user)
        get edit_undone_action_path(undone_action)
        expect(response.status).to eq(200)
      end
    end
  end

  #delete
  describe 'DELETE /blogs/:id' do
    let(:undone_action) { create(:undone_action, user: current_user) }
    context 'delete own undone_action' do
      it "redirect to root page" do
        delete undone_action_path(undone_action)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("was successfully destroyed")
      end
    end

    context 'try to delete other users undone_action' do
      it "redirect to root page without notice" do
        other_undone_action = create(:undone_action_other)
        delete undone_action_path(other_undone_action)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).not_to include("was successfully destroyed")
      end
    end
  end



end
