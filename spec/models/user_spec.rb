# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friended_users) }
    it { should have_many(:friends) }
    it { should have_many(:users_who_friended) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end

    it "user starts with nil github_token" do
      user = create(:user)

      expect(user.github_token).to eq(nil)
    end
  end

  describe 'instance methods' do
    describe 'email_unconfirmed?' do
      it "returns true if user hasn't confirmed their email" do
        user = create(:user, status: 0)

        assert(user.email_unconfirmed?)
      end
    end
  end
end
