require 'rails_helper'

RSpec.describe UndoneAction, type: :model do

  before do
    @u_action = create(:undone_action)
    @u_action_other = build(:undone_action_other)
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
  end

  #正常系
  it "is valid with action_name and user_id" do
    u_action = @u_action
    expect(u_action).to be_valid
  end

  #異常系
  it 'is invalid without a action_name' do
    u_action = @u_action
    u_action.action_name = ""
    u_action.valid?
    expect(u_action.errors.messages[:action_name]).to include("can't be blank")
  end

  it 'is invalid without a default_time' do
    u_action = @u_action
    u_action.default_time = ""
    u_action.valid?
    expect(u_action.errors.messages[:default_time]).to include("can't be blank")
  end

  #境界値分析
  it 'is valid with 25文字のaction_name' do
    u_action = @u_action
    u_action.action_name = "a" * 25
    expect(u_action).to be_valid
  end

  it 'is invalid with 26文字のaction_name' do
    u_action = @u_action
    u_action.action_name = "a" * 26
    u_action.valid?
    expect(u_action.errors.messages[:action_name]).to include("is too long (maximum is 25 characters)")
  end

  it 'is valid with 4文字のdefault_time' do
    u_action = @u_action
    u_action.default_time = "1234"
    expect(u_action).to be_valid
  end

  it 'is invalid with 5文字のdefault_time' do
    u_action = @u_action
    u_action.default_time = "12345"
    u_action.valid?
    expect(u_action.errors.messages[:default_time]).to include("is too long (maximum is 4 characters)")
  end

  #一意性
  it 'action_nameは一意' do
    u_action = @u_action
    u_action_other = @u_action_other
    u_action_other.valid?
    expect(u_action_other.errors.messages[:action_name]).to include("has already been taken")
  end

end

