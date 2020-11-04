require 'rails_helper'

RSpec.describe "Homes", type: :request do

  before {
    timestamp!
    log_in
  }

  #top
  describe "GET root" do
    context 'when loged in' do
      it "render to top" do
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to include(current_user.name)
      end
    end

    context 'when not loged in' do
      it "render to mypage" do
        log_out
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).not_to include(current_user.name)
      end
    end
  end
end
