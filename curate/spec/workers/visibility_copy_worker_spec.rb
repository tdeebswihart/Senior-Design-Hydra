require 'spec_helper'

describe VisibilityCopyWorker do

  describe "an open access work" do
    let(:work) { FactoryGirl.create(:generic_work_with_files, visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC) }
    subject { VisibilityCopyWorker.new(work.id) }

    it "should have no content at the outset" do
      work.generic_files.first.visibility.should == Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
    end

    it "should copy visibility to its contained files" do
      subject.run
      work.generic_files.each do |file|
        file.visibility.should == 'open'
      end
    end
  end

  describe "an embargoed work" do
    let(:embargo_date) { 2.days.from_now }
    let(:work) { FactoryGirl.create(:generic_work_with_files, visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC, embargo_release_date: embargo_date) }
    subject { VisibilityCopyWorker.new(work.id) }

    it "should have no content at the outset" do
      work.should be_open_access_with_embargo_release_date
      work.generic_files.first.should_not be_open_access_with_embargo_release_date
    end

    it "should copy visibility to its contained files" do
      subject.run
      work.reload
      work.generic_files.each do |file|
        file.should be_open_access_with_embargo_release_date
      end
    end
  end

end
