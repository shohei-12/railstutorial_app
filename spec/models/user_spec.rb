require 'rails_helper'

RSpec.describe User, type: :model do
  it 'must be a valid user' do
    expect(build(:user)).to be_valid
  end

  it 'must be saved as lower-case in email' do
    user = create(:user, email: 'user@example.com'.upcase)
    expect('user@example.com').to eq user.email
  end

  describe 'validations' do
    subject { User.new }

    describe 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end

    describe 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it 'must be unique' do
        create(:user)
        user = build(:user)
        expect(user).not_to be_valid
      end
      it 'must be allow valid addresses' do
        is_expected.to allow_values(
          'user@example.com',
          'USER@foo.COM',
          'A_US-ER@foo.bar.org',
          'first.last@foo.jp',
          'alice+bob@baz.cn'
        ).for(:email)
      end
      it 'must reject invalid addresses' do
        is_expected.not_to allow_values(
          'user@example,com',
          'user_at_foo.org',
          'user.name@example.',
          'foo@bar_baz.com',
          'foo@bar+baz.com',
          'foo@bar..com'
        ).for(:email)
      end
    end

    describe 'password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end
  end

  it 'authenticated? must return false for a user with nil digest' do
    expect(build(:user).authenticated?('')).to be_falsey
  end

  context 'deleting a user' do
    it 'must delete  microposts associated to a user' do
      user = create(:user)
      orange = create(:orange, user_id: user.id)
      user.destroy
      expect(Micropost.count).to eq 0
    end
  end
end
