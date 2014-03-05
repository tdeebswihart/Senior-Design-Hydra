require 'spec_helper'
require "cancan/matchers"

describe "User" do
  describe "Abilities" do
    subject { Ability.new(current_user) }

    let(:generic_work) { FactoryGirl.create(:private_generic_work, user: creating_user ) }
    let(:user) { FactoryGirl.create(:user) }

    describe 'without embargo' do
      describe 'creator of object' do
        let(:creating_user) { user }
        let(:current_user) { user }
        it {
          should be_able_to(:create, GenericWork.new)
          should be_able_to(:read, generic_work)
          should be_able_to(:update, generic_work)
          should be_able_to(:destroy, generic_work)
        }
      end

      describe 'as a proxy for the creator of object' do
        let(:proxy_user) { FactoryGirl.create(:user) }
        before do
          creating_user.can_receive_deposits_from << proxy_user
        end
        let(:creating_user) { user }
        let(:current_user) { proxy_user }
        it {
          should be_able_to(:create, GenericWork.new)
          should be_able_to(:read, generic_work)
          should be_able_to(:update, generic_work)
          should be_able_to(:destroy, generic_work)
        }
      end

      describe 'as a repository manager' do
        let(:email) { 'manager@example.com' }
        let(:manager_user) { FactoryGirl.create(:user, email: email) }
        let(:creating_user) { user }
        let(:current_user) { manager_user }
        it {
          should be_able_to(:create, GenericWork.new)
          should be_able_to(:read, generic_work)
          should be_able_to(:update, generic_work)
          should be_able_to(:destroy, generic_work)
        }
      end

      describe 'another authenticated user' do
        let(:creating_user) { FactoryGirl.create(:user) }
        let(:current_user) { user }
        it {
          should be_able_to(:create, GenericWork.new)
          should_not be_able_to(:read, generic_work)
          should_not be_able_to(:update, generic_work)
          should_not be_able_to(:destroy, generic_work)
        }
      end

      describe 'a nil user' do
        let(:creating_user) { FactoryGirl.create(:user) }
        let(:current_user) { nil }
        it {
          should_not be_able_to(:create, GenericWork.new)
          should_not be_able_to(:read, generic_work)
          should_not be_able_to(:update, generic_work)
          should_not be_able_to(:destroy, generic_work)
        }
      end
    end
  end
end
