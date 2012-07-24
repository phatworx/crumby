# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "active_support/all"

class DummyController
  include Crumby::Helper
end

describe Crumby::Helper do
  # let(:controller) { DummyController.new }

  # describe "#breadcrumb" do
  #   subject { controller.breadcrumb }
  #   it { should be_an Crumby::Breadcrumb }
  # end

  # context "#crumb_title" do
  #   subject { controller }
  #   it "passthrough arguments to breadcrumb#title" do
  #     args = stub :args
  #     subject.breadcrumb.should_receive(:title).with(args)
  #     subject.crumb_title(args)
  #   end
  # end

  # context "#add_crumb" do
  #   subject { controller }
  #   it "passthrough arguments to breadcrumb#add" do
  #     args = stub :args
  #     subject.breadcrumb.should_receive(:add).with(args)
  #     subject.add_crumb(args)
  #   end
  # end

  # describe "#crumby_items" do
  #   subject { controller.crumby_items }

  #   it { should be_an Array }

  #   context "have no items" do
  #     its(:count) { should be_zero }
  #   end

  #   context "have some items" do
  #     before :all do
  #       controller.add_crumb(:test)
  #     end

  #     its(:count) { should_not be_zero }
  #   end
  # end

  # describe "#crumby_title" do
  #   before :all do
  #     controller.add_crumb(:first)
  #     controller.add_crumb(:second)
  #     controller.add_crumb(:third)
  #   end

  #   context "without name" do
  #     subject { controller.crumby_title }
  #     it { should eq "Third » Second" }
  #   end

  #   context "with name" do
  #     subject { controller.crumby_title("Spec-Title") }
  #     it { should eq "Third » Second » Spec-Title" }
  #   end

  #   context "with own divider" do
  #     subject { controller.crumby_title({ divider: " - "}) }
  #     it { should eq "Third - Second" }
  #   end


  #   context "with option skip first true" do
  #     subject { controller.crumby_title({ skip_first: true}) }
  #     it { should eq "Third » Second" }
  #   end

  #   context "with option skip first false" do
  #     subject { controller.crumby_title({ skip_first: false}) }
  #     it { should eq "Third » Second » First" }
  #   end

  # end

  # describe "#crumby" do
  #   context ""
  # end

end
