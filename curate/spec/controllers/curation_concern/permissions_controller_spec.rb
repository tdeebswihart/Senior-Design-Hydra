require 'spec_helper'

describe CurationConcern::PermissionsController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "#confirm" do
    let(:generic_work) { FactoryGirl.create(:generic_work, user: user) }

    it "should draw the page" do
      get :confirm, id: generic_work
      expect(response).to be_success
    end
  end

  describe "#copy" do
    let(:generic_work) { FactoryGirl.create(:generic_work, user: user) }

    it "should add a worker to the queue" do
      worker = double
      VisibilityCopyWorker.should_receive(:new).with(generic_work.pid).and_return(worker)
      Sufia.queue.should_receive(:push).with(worker)
      post :copy, id: generic_work
      expect(response).to redirect_to controller.polymorphic_path([:curation_concern, generic_work])
      expect(flash[:notice]).to eq 'Updating file permissions. This may take a few minutes.'
    end
  end

end
