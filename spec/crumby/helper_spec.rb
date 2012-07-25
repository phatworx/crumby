# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "active_support/all"

class DummyController
  include Crumby::Helper
end

describe Crumby::Helper do
  let(:controller) { DummyController.new }

  describe "#crumbs" do

    let! (:default_breadcrumbs) { controller.crumbs(:default) }
    let! (:different_breadcrumbs) { controller.crumbs(:different) }

    it "should match default scope with \":default\"" do
      controller.crumbs(:default).should equal default_breadcrumbs
    end

    it "should match default scope with \"default\"" do
      controller.crumbs("default").should equal default_breadcrumbs
    end

    it "should match diffrent scope with \":diffrent\"" do
      controller.crumbs(:different).should equal different_breadcrumbs
    end

    it "should not match default or diffrent scope with \":other\"" do
      controller.crumbs(:other).should_not equal default_breadcrumbs
      controller.crumbs(:other).should_not equal different_breadcrumbs
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
    let (:renderer) { stub :renderer }
    let (:breadcrumbs) { stub :breadcrumbs }

    before :each do
      renderer.stub(:render)
      breadcrumbs.stub(:renderer).and_return(renderer)
      controller.stub(:crumbs).and_return(breadcrumbs)
    end

    context "with default scope" do
      after { controller.breadcrumbs }

      it "should load crumb" do
        controller.should_receive(:crumbs).with(:default)
      end
    end

    context "with :test scope" do
      after { controller.breadcrumbs :test }

      it "should load crumb" do
        controller.should_receive(:crumbs).with(:test)
      end
    end

    context "with default renderer" do
      after { controller.breadcrumbs }

      it "should call renderer" do
        breadcrumbs.should_receive(:renderer).with(nil)
      end

      it "should call render on renderer with options" do
        renderer.should_receive(:render).with(kind_of Hash)
      end
    end

    context "with custom renderer" do
      after { controller.breadcrumbs renderer: renderer, option: true }

      it "should call renderer" do
        breadcrumbs.should_receive(:renderer).with(renderer)
      end

      it "should call render on renderer with options" do
        renderer.should_receive(:render).with(hash_including(option: true))
      end
    end
  end





    # it "should call crumbs with scope :default" do
    #   controller.should_receive(:crumbs).with(:default)

    # end

    # it "should call crumbs with scope :other" do
    #   controller.should_receive(:crumbs).with(:other)
    #   controller.breadcrumbs(:other)
    # end

    # context "with default render" do

    #   it "should call render on default renderer" do
    #     breadcrumbs.should_receive(:renderer).with(nil)
    #     controller.breadcrumbs
    #   end


    # end

    # context "with custom" do

    # end


end
