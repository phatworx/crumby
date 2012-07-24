# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "active_support/all"

class DummyController
  include Crumby::Helper
end

describe Crumby::Helper do
  let(:controller) { DummyController.new }

  describe "#crumbs" do
    subject { controller.crumbs }
    it { should be_an Crumby::Breadcrumbs }

    context "different scope" do
      subject { controller.crumbs(:different) }
      it { should be_an Crumby::Breadcrumbs }
      it "should diffrent to default breadcrumbs" do
        controller.crumbs.should_not equal subject
      end
    end
  end

  describe "#add_crumb" do

    let(:label) { "Name" }
    let(:route) { :route }
    let(:options) { { the_options: true, the_options2: true } }

    subject { controller.crumbs }

    it "should receive all arguments" do
      controller.crumbs.should_receive(:add).with(label, route, options)
      controller.add_crumb(label, route, options)
    end

    context "with a diffrent scope" do
      let(:scope) { :a_different }
      subject { controller.crumbs(scope) }

      it "should receive all arguments" do
        subject.should_receive(:add).with(label, route, kind_of(Hash))
        controller.add_crumb(label, route, scope: scope)
      end
    end
  end

  describe "#crumby_title" do
    subject { controller.crumbs }

    it "should call title on breadcrumbs" do
      controller.crumbs.should_receive(:title).with(no_args)
      controller.crumby_title
    end

    context "with a diffrent scope" do
      let(:scope) { :a_different }
      subject { controller.crumbs(scope) }

      it "should call title on breadcrumbs" do
        subject.should_receive(:title).with(no_args)
        controller.crumby_title(scope)
      end
    end

  end

  describe "#breadcrumbs" do
    pending "work in progress"
  end

end
