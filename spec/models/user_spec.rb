require 'rails_helper'

RSpec.describe User, type: :model do

  
  describe 'ユーザー新規登録' do
    it 'nameが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.name = ''  # nicknameの値を空にする
      user.valid?
      expect(user.errors.full_messages).to include("Nameを入力してください")
    end
    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.email = ''  # emailの値を空にする
      user.valid?
      expect(user.errors.full_messages).to include("Eメールを入力してください")
    end
  end
end