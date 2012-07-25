# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "active_support/all"

class DummyController
  include Crumby::Helper
end

describe Crumby::Helper do
  let(:controller) { DummyController.new }

  describe "#crumby_trail" do

    let! (:default_trail) { controller.crumby_trail(:default) }
    let! (:different_trail) { controller.crumby_trail(:different) }

    it "should match default scope with \":default\"" do
      controller.crumby_trail(:default).should equal default_trail
    end

    it "should match default scope with \"default\"" do
      controller.crumby_trail("default").should equal default_trail
    end

    it "should match diffrent scope with \":diffrent\"" do
      controller.crumby_trail(:different).should equal different_trail
    end

    it "should not match default or diffrent scope with \":other\"" do
      controller.crumby_trail(:other).should_not equal default_trail
      controller.crumby_trail(:other).should_not equal different_trail
    end




  end

  describe "#add_crumby" do

    let(:label) { "Name" }
    let(:route) { :route }
    let(:options) { { the_options: true, the_options2: true } }

    subject { controller.crumby_trail }

    it "should receive all arguments" do
      controller.crumby_trail.should_receive(:add).with(label, route, options)
      controller.add_crumby(label, route, options)
    end

    context "with a diffrent scope" do
      let(:scope) { :a_different }
      subject { controller.crumby_trail(scope) }

      it "should receive all arguments" do
        subject.should_receive(:add).with(label, route, kind_of(Hash))
        controller.add_crumby(label, route, scope: scope)
      end
    end
  end

  describe "#crumby_title" do
    subject { controller.crumby_trail }

    it "should call title on trail" do
      controller.crumby_trail.should_receive(:title).with(no_args)
      controller.crumby_title
    end

    context "with a diffrent scope" do
      let(:scope) { :a_different }
      subject { controller.crumby_trail(scope) }

      it "should call title on trail" do
        subject.should_receive(:title).with(no_args)
        controller.crumby_title(scope)
      end
    end

  end

  describe "#crumby" do
    let (:renderer) { stub :renderer }
    let (:trail) { stub :trail }

    before :each do
      renderer.stub(:render)
      trail.stub(:renderer).and_return(renderer)
      controller.stub(:crumby_trail).and_return(trail)
    end

    context "with default scope" do
      after { controller.crumby }

      it "should load crumb" do
        controller.should_receive(:crumby_trail).with(:default)
      end
    end

    context "with :test scope" do
      after { controller.crumby :test }

      it "should load crumb" do
        controller.should_receive(:crumby_trail).with(:test)
      end
    end

    context "with default renderer" do
      after { controller.crumby }

      it "should call renderer" do
        trail.should_receive(:renderer).with(nil)
      end

      it "should call render on renderer with options" do
        renderer.should_receive(:render).with(kind_of Hash)
      end
    end

    context "with custom renderer" do
      after { controller.crumby renderer: renderer, option: true }

      it "should call renderer" do
        trail.should_receive(:renderer).with(renderer)
      end

      it "should call render on renderer with options" do
        renderer.should_receive(:render).with(hash_including(option: true))
      end
    end
  end

end
