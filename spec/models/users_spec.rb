require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'ユーザー作成時のバリデーション' do
    it 'user_nameとfull_nameとpasswordの値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'user_nameが空だとNG' do
      @user.user_name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'user_nameが51文字以上だとNG' do
      @user.user_name = 'a' * 51
      expect(@user.valid?).to eq(false)
    end

    it 'full_nameが空だとNG' do
      @user.full_name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'full_nameが51文字以上だとNG' do
      @user.full_name = 'a' * 51
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
    end
  end

  describe 'プロフィール変更時のバリデーション' do
    it '自己紹介が151文字以上だとNG' do
      @user.introduction = 'a' * 151
      expect(@user.valid?).to eq(false)
    end

    it 'emailが256文字以上だとNG' do
      @user.email = 'a' * 244 + "@example.com"
      expect(@user.valid?).to eq(false)
    end

    it 'phoneにハイフンが入ってたらNG' do
      @user.phone = '080-9999-9999'
      expect(@user.valid?).to eq(false)
    end

    it 'phoneが10文字か11文字じゃなかったらNG' do
      @user.phone = '0' * 9
      expect(@user.valid?).to eq(false)
      @user.phone = '0' * 12
      expect(@user.valid?).to eq(false)
    end
  end
end
