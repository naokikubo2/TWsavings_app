require 'rails_helper'

RSpec.describe "SavingsRecords", type: :request do

  before {
    timestamp!
    log_in
  }

  #new
  describe "GET /savings_records/new" do
    it "render to new page" do
      get new_savings_record_path
      expect(response.status).to eq(200)
    end
  end

  #create
  describe "POST /savings_records/:id/create" do
    context 'valid params' do
      it "redirect to root page" do
        post savings_records_path, params: { savings_record:
          { user_id: current_user.id, savings_name: "Created #{timestamp}", savings_time: Date.today, earned_time: "10"} }
        expect(response).to redirect_to(new_savings_record_path)
      end
    end

    context 'invalid params' do
      it "render to new page" do
        post savings_records_path, params: { savings_record: { user_id: current_user.id, savings_name: "", earned_time: ""} }
        expect(response.status).to eq(200)
      end
    end
  end

  #index
  describe "GET /savings_records" do

    before {
      (1..2).each {|index|
        create(:savings_record, user_id: current_user.id, savings_name: "Name#{index}#{timestamp}")
      }
    }

    context 'when not loged in' do
      it "redirect to sign in" do
        log_out
        get savings_records_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when loged in' do
      it "render to index page" do
        get savings_records_path
        expect(response.status).to eq(200)
        expect(response.body).to include("Name1#{timestamp}")
        expect(response.body).to include("Name2#{timestamp}")
      end
    end
  end


  #destroy
  describe 'DELETE /savings_records/:id' do
    let(:savings_record) { create(:savings_record, user: current_user) }
    context 'delete own savings_record' do
      it "redirect to new page" do
        delete savings_record_path(savings_record)
        expect(response).to redirect_to(savings_records_url)
        follow_redirect!
        expect(response.body).to include("貯金履歴の削除に成功しました")
      end
    end

    context 'try to delete other users undone_action' do
      it "redirect to root page without notice" do
        other_savings_record = create(:savings_record_other)
        delete savings_record_path(other_savings_record)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).not_to include("貯金履歴の削除に成功しました")
      end
    end
  end
end
