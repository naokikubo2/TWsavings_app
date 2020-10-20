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

  #create
  describe "POST /undone_actions/:id/create" do
    context 'valid params' do
      it "redirect to root page" do
        post undone_actions_path, params: { undone_action: { user_id: current_user.id, action_name: "Created #{timestamp}", default_time: "1"} }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid params' do
      it "render to new page" do
        post undone_actions_path, params: { undone_action: { user_id: current_user.id, action_name: "", default_time: ""} }
        expect(response.status).to eq(200)
      end
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

  #update
  describe "PUT /undone_actions/:id" do
    let(:undone_action) { create(:undone_action, user: current_user) }
    context 'valid params' do
      it "redirect to root page" do
        put undone_action_path(undone_action), params: { undone_action: { user_id: current_user.id, action_name: "Updated #{timestamp}"} }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("不要行動の更新に成功しました")
        expect(response.body).to include("Updated #{timestamp}")
      end
    end

    context 'invalid params' do
      it "render to edit page" do
        put undone_action_path(undone_action), params: { undone_action: { user_id: current_user.id, action_name: "", default_time: ""} }
        expect(response.status).to eq(200)
        expect(response.body).to include("不要行動の名前を入力してください")
        expect(response.body).to include("所要時間を入力してください")
      end
    end

    context 'try to update other users other_undone_action' do
      it "redirect to root page" do
        other_undone_action = create(:undone_action_other)
        put undone_action_path(other_undone_action), params: { other_undone_action: { user_id: current_user.id, action_name: "actionname"} }
        expect(response).to redirect_to(root_path)
      end
    end
  end


  #destroy
  describe 'DELETE /undone_actions/:id' do
    let(:undone_action) { create(:undone_action, user: current_user) }
    context 'delete own undone_action' do
      it "redirect to root page" do
        delete undone_action_path(undone_action)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("不要行動の削除に成功しました")
      end
    end

    context 'try to delete other users undone_action' do
      it "redirect to root page without notice" do
        other_undone_action = create(:undone_action_other)
        delete undone_action_path(other_undone_action)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).not_to include("不要行動の削除に成功しました")
      end
    end
  end



end
