# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Crumby::Renderer::Base do
  let(:trail) { stub :trail }
  let(:view) { stub :view }
  let(:options) { stub :options }
  subject { Crumby::Renderer::Base.new(trail) }

  describe "#new" do
    its(:trail) { should equal trail }
  end

  describe "#render" do
    pending "todo"
  end

  describe "#default_options" do
    it { subject.default_options.should be_empty }
  end

  describe "#render_list" do
    it "should raise a NotImplementedError error" do
      expect { subject.render_list(stub) }.to raise_error NotImplementedError
    end
  end

  describe "#render_entry" do
    it "should raise a NotImplementedError error" do
      expect { subject.render_entry(stub, stub) }.to raise_error NotImplementedError
    end
  end

end
