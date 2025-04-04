require 'rails_helper'

RSpec.describe User, type: :model do
  before { create(:user) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }

  describe 'password validations' do
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
