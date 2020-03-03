require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe 'keywords' do
    it { should have_secure_token :api_key }
    it { should have_secure_password }
  end

  describe 'methods' do
    describe 'class methods' do
      describe 'authenticate_token' do
        it 'returns true if api_key exists on users table and false if not' do
          user_1 = create(:user)
          expect(User.authenticate_token(user_1.api_key)).to eq(true)
          expect(User.authenticate_token('aaaabbbbccccddddeeeeffff')).to eq(false)
        end
      end
    end
  end
end
