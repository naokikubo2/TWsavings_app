require 'rails_helper'

RSpec.describe SavingsRecord, type: :model do
  before do
    @savings_rec = create(:savings_record)
    @savings_rec_other = build(:savings_record_other)
  end

  # 関連付けのテスト
  describe 'Association' do
    let(:association) do
      # reflect_on_associationで対象のクラスと引数で指定するクラスの
      # 関連を返します
      described_class.reflect_on_association(target)
    end

    # userとの関連付けをチェックしたい場合
    context 'User' do
      # targetは :user に設定
      let(:target) { :user }

      # macro メソッドで関連づけを返します
      it { expect(association.macro).to eq :belongs_to }

      # class_name で関連づいたクラス名を返します
      it { expect(association.class_name).to eq 'User' }
    end

    #正常系
    it 'is valid with savings_name, earned_time and savings_date' do
      savings_rec = @savings_rec
      expect(savings_rec).to be_valid
    end

    #異常系
    it 'is invalid without a savings_name' do
      savings_rec = @savings_rec
      savings_rec.savings_name = ""
      savings_rec.valid?
      expect(savings_rec.errors.messages[:savings_name]).to include("を入力してください")
    end

    it 'is invalid without a earned_time' do
      savings_rec = @savings_rec
      savings_rec.earned_time = ""
      savings_rec.valid?
      expect(savings_rec.errors.messages[:earned_time]).to include("を入力してください")
    end

    it 'is invalid without a savings_date' do
      savings_rec = @savings_rec
      savings_rec.savings_date = ""
      savings_rec.valid?
      expect(savings_rec.errors.messages[:savings_date]).to include("を入力してください")
    end

    #境界値分析
    it 'is valid with 25文字のsavings_name' do
      savings_rec = @savings_rec
      savings_rec.savings_name = "a" * 25
      expect(savings_rec).to be_valid
    end

    it 'is invalid with 26文字のsavings_name' do
      savings_rec = @savings_rec
      savings_rec.savings_name = "a" * 26
      savings_rec.valid?
      expect(savings_rec.errors.messages[:savings_name]).to include("は25文字以内で入力してください")
    end

    it 'is valid with 4文字のearned_time' do
      savings_rec = @savings_rec
      savings_rec.earned_time = "1234"
      expect(savings_rec).to be_valid
    end

    it 'is invalid with 5文字のearned_time' do
      savings_rec = @savings_rec
      savings_rec.earned_time = "12345"
      savings_rec.valid?
      expect(savings_rec.errors.messages[:earned_time]).to include("は4文字以内で入力してください")
    end

    it 'is valid with 今日' do
      savings_rec = @savings_rec
      savings_rec.savings_date= Date.today
      expect(savings_rec).to be_valid
    end

    it 'is invalid with 明日' do
      savings_rec = @savings_rec
      savings_rec.savings_date = Date.today+1
      savings_rec.valid?
      expect(savings_rec.errors.messages[:savings_date]).to include("は今日以前のものを選択してください")
    end

  end
end
