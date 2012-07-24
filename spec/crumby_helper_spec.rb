# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "active_support/all"

class DummyController
  include Crumby::Helper
end

class DummyModelName
  def human
    "dummy human name"
  end
end

class DummyModel
  def model_name
    DummyModelName.new
  end
end

describe Crumby::Helper do
  let(:controller) { DummyController.new }

  describe "#add_crumb" do
    context "without an argument" do
      it "should get an ArgumentError" do
        expect { controller.add_crumb }.to raise_error(ArgumentError)
      end
    end

    context "with one argument" do
      subject { controller.add_crumb(first_argument) }

      context "that is a string" do
        let(:first_argument) { "example string" }
        its(:label) { should equal first_argument }
        its(:route) { should be_nil }
      end

      context "that is a symbol" do
        let(:first_argument) { :example_string }
        its(:label) { should eq first_argument.to_s.humanize }
        its(:route) { should equal first_argument }
      end

      context "that is an object with model_name method" do
        let(:first_argument) { DummyModel.new }
        its(:label) { should eq first_argument.model_name.human }
        its(:route) { should equal first_argument }
      end
      context "that is an array of objects" do
        context "last is an object with model_name method" do
          let(:first_argument) { [:admin, DummyModel.new] }
          its(:label) { should eq first_argument.last.model_name.human }
          its(:route) { should equal first_argument }
        end

        context "last is a string" do
          let(:first_argument) { [:admin, "other string"] }
          its(:label) { should eq first_argument.last.to_s.humanize }
          its(:route) { should equal first_argument }
        end

      end

    end

    context "with label and route argument" do
      let(:label) { "Name" }
      let(:route) { :route }

      subject { controller.add_crumb(label, route) }

      its(:label) { should equal label }
      its(:route) { should equal route }
    end

    context "with options" do
      let(:options) { { option1: true, option2: false, string: "Text" } }
      subject { controller.add_crumb(:test, options) }
      its(:options) { should equal options }
    end

  end

  describe "#crumby_items" do
    subject { controller.crumby_items }

    it { should be_an Array }

    context "have no items" do
      its(:count) { should be_zero }
    end

    context "have some items" do
      before :all do
        controller.add_crumb(:test)
      end

      its(:count) { should_not be_zero }
    end
  end

  describe "#crumby_title" do
    before :all do
      controller.add_crumb(:first)
      controller.add_crumb(:second)
      controller.add_crumb(:third)
    end

    context "without name" do
      subject { controller.crumby_title }
      it { should eq "Third » Second" }
    end

    context "with name" do
      subject { controller.crumby_title("Spec-Title") }
      it { should eq "Third » Second » Spec-Title" }
    end

    context "with own divider" do
      subject { controller.crumby_title({ divider: " - "}) }
      it { should eq "Third - Second" }
    end


    context "with option skip first true" do
      subject { controller.crumby_title({ skip_first: true}) }
      it { should eq "Third » Second" }
    end

    context "with option skip first false" do
      subject { controller.crumby_title({ skip_first: false}) }
      it { should eq "Third » Second » First" }
    end

  end
  context "#crumby" do
    pending "tue es"
  end

end
