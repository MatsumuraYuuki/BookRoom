require 'rails_helper'

RSpec.describe User, type: :model do

  describe User do
    let(:user_name) { 'テスト太郎' }
    let(:email) { 'test@example.com' }
    let(:password) { '12345678' }
    let(:user) { User.new(user_name: user_name, email: email, password: password, password_confirmation: password) }

    describe 'User.first' do

      before do
        create(:user, user_name: user_name, email: email)
      end

      subject { described_class.first }

      it '事前に作成した通りのUserを返す' do
        expect(subject.user_name).to eq('テスト太郎')
        expect(subject.email).to eq('test@example.com')
      end
      
    end

    describe 'User.validation' do

      describe 'user_name属性' do
        describe '文字数制限の検証' do
          context 'nicknameが20文字以下の場合' do
            let(:user_name) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

            it 'User オブジェクトは有効である' do
              expect(user.valid?).to be(true)
            end
          end

          context 'nicknameが20文字を超える場合' do
            let(:user_name) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

            it 'User オブジェクトは無効である' do
              user.valid?
  
              expect(user.valid?).to be(false)
              expect(user.errors[:user_name]).to include('is too long (maximum is 20 characters)')
            end
          end
        end

        describe 'user_name存在性の検証' do
          context 'nicknameが空欄の場合' do
            let(:user_name) { '' }
    
            it 'User オブジェクトは無効である' do
              expect(user.valid?).to be(false)
              expect(user.errors[:user_name]).to include("can't be blank")
            end
          end
        end
      end

    end
  end
end
