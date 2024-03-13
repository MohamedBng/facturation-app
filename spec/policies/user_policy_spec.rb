require 'rails_helper'
require 'pundit/rspec'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, record) }

  let(:admin) { build_stubbed(:user, role: 'admin') }
  let(:random_user) { build_stubbed(:user, role: 'user') }
  let(:record) { build_stubbed(:user) }

  describe "Access as Admin" do
    let(:user) { admin }

    it "allows index access" do
      expect(subject.index?).to be true
    end

    it "allows show access" do
      expect(subject.show?).to be true
    end

    it "allows create access" do
      expect(subject.create?).to be true
    end

    it "allows new access" do
      expect(subject.new?).to be true
    end

    it "allows update access" do
      expect(subject.update?).to be true
    end

    it "allows edit access" do
      expect(subject.edit?).to be true
    end

    it "allows destroy access" do
      expect(subject.destroy?).to be true
    end
  end

  describe "Access as user" do
    let(:user) { random_user }

    it "denies index access" do
      expect(subject.index?).to be false
    end

    it "denies create access" do
      expect(subject.create?).to be false
    end

    it "denies new access" do
      expect(subject.new?).to be false
    end

    it "denies update access for other users' records" do
      expect(subject.update?).to be false
    end

    it "denies edit access for other users' records" do
      expect(subject.edit?).to be false
    end

    it "denies destroy access" do
      expect(subject.destroy?).to be false
    end
  end

  describe "Access for Own Record when user" do
    let(:user) { create(:user, role: "user") }
    let(:record) { user }

    it "allows show access for their own record" do
      expect(subject.show?).to be true
    end

    it "allows update access for their own record" do
      expect(subject.update?).to be true
    end

    it "allows edit access for their own record" do
      expect(subject.edit?).to be true
    end

    it "denies destroy access for their own record" do
      expect(subject.destroy?).to be false
    end
  end

  describe "Access for Own Record when Admin" do
    let(:user) { create(:user, role: "admin") }
    let(:record) { user }

    it "allows show access for their own record" do
      expect(subject.show?).to be true
    end

    it "allows update access for their own record" do
      expect(subject.update?).to be true
    end

    it "allows edit access for their own record" do
      expect(subject.edit?).to be true
    end

    it "denies destroy access for their own record" do
      expect(subject.destroy?).to be true
    end
  end
end
