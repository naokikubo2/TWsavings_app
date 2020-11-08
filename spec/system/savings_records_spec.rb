require "rails_helper"

RSpec.describe "Savings_records", type: :system do
  let(:user) { create(:user) }
  let(:login_user) { user }
  let!(:savings_record) { create(:savings_record, user: user) }

  before {
    log_in(login_user, type: :system)
    visit savings_record_path(savings_record)
  }


  describe 'comment' do
    before {
      timestamp!
    }
    context "when own comment" do
      it 'post and deletable' do
        first("#comments_content").set("Comment#{timestamp}")
        first('input[value="コメント"]').click
        wait_until {
          all("#comments div").last.present?
        }
        expect(all("#comments div").last.text).to eq("Comment#{timestamp}")

        all("#comments div").last.first("a").click
        wait_until(7) {
          # check deleted
          all("#comments div").last.nil?
        }
      end
    end

    context "when other users comment" do
      it 'non display delete link' do
        create(:comment, savings_record: savings_record, user: create(:user))
        # page reload
        visit current_path
        wait_until {
          all("#comments div").last.present?
        }
        expect(all("#comments div").last.all("a")).to be_empty
      end
    end
  end
end
