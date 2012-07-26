# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class DummyRenderer < Crumby::Renderer::Haml
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

def DummyRenderer
end

describe Crumby::Trail do
  let(:trail) { Crumby::Trail.new } # use subject
  let(:rendered) { stub :rendered }
  let(:renderer) { stub :renderer, render: rendered }
  let(:default_renderer) { Renderer.default_renderer.stub renderer: renderer }
  let(:custom_renderer) { DummyRenderer.stub :renderer, renderer: renderer }

  context "have 10 entries" do
    before { 10.times { subject.add :entry } }

    its(:count) {should eq 10}

    it "each breadcrumb should have the correct position" do
      10.times do |position|
        subject.entries[position].position.should eq position
      end
    end

  end


  describe "#add" do

    context "without an argument" do
      it "should get an ArgumentError" do
        expect { subject.add }.to raise_error(ArgumentError)
      end
    end

    context "with one argument" do
      subject { trail.add first_argument }

      context "that is a string" do
        let(:first_argument) { "example string" }
        its(:label) { should equal first_argument }
        its(:route) { should be_nil }
      end

      context "that is a symbol" do
        let(:first_argument) { :example_symbol }
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

      context "that any other type" do
        let(:first_argument) { 5.5 }
        its(:label) { should eq first_argument.to_s.humanize }
        its(:route) { should be_nil }
      end
    end

    context "with label and route argument" do
      let(:label) { "Name" }
      let(:route) { :route }

      subject { trail.add(label, route) }

      its(:label) { should equal label }
      its(:route) { should equal route }
    end

    context "with options" do
      let(:options) { { option1: true, option2: false, string: "Text" } }
      subject { trail.add(:test, options) }
      its(:options) { should equal options }
    end
  end

  describe "#entries" do
    subject { trail.entries }

    it { should be_an Array }

    context "have no entry" do
      its(:count) { should be_zero }
    end

    context "have on entry" do
      subject { trail.add :test }
      its(:count) { should_not be_zero }
    end
  end

  describe '#renderer' do

    subject { trail }

    context "without an arguments" do
      it "should return default renderer" do
        Crumby::Renderer.default_renderer.should_receive(:new).with(subject)
        subject.send(:renderer)
      end
    end

    context "with a DummyRenderer renderer" do
      let(:renderer) { DummyRenderer }
      it "should return the DummyRenderer renderer" do
        renderer.should_receive(:new).with(subject)
        subject.send(:renderer, renderer)
      end
    end

    context "with a String" do
      let(:renderer) { "String" }
      it "raise an ArgumentError" do
        expect { subject.send(:renderer, renderer) }.to raise_error(ArgumentError)
      end
    end

    context "with an renderer class" do
    end
  end

  # describe "#render" do


  #   context "with default renderer" do
  #     after { trail.render }

  #     it "should load default renderer" do
  #       trail.should_receive(:renderer).with(nil).and_return(renderer)
  #     end
  #   end

  #   context "with custom renderer" do
  #     after { trail.render renderer: DummyRenderer }

  #     it "should load custom renderer" do
  #       trail.should_receive(:renderer).with(DummyRenderer).and_return(renderer)
  #     end
  #   end
  # end

  # describe "#renderer" do
  #   it "should raise ArgumentError with String class" do
  #     expect {
  #       trail.renderer String
  #     }.to raise_error ArgumentError
  #   end

  #   it "should raise ArgumentError with instance of String" do
  #     expect {
  #       trail.renderer "String"
  #     }.to raise_error ArgumentError
  #   end

  #   context "without renderer" do
  #     after { trail.renderer }

  #     it "should return instance of default renderer with trail" do
  #       Crumby::Renderer.default_renderer.should_receive(:new).with(trail)
  #     end
  #   end

  #   context "with custom renderer" do
  #     after { trail.renderer DummyRenderer }

  #     it "should return instance of DummyRenderer with trail" do
  #       DummyRenderer.should_receive(:new).with(trail)
  #     end
  #   end
  # end


end
