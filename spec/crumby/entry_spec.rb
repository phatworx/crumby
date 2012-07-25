# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Crumby::Entry do

  context "#new" do
    let(:entry_label) { "TestLabel" }
    let(:entry_route) { :test }
    let(:entry_options) { { test: true } }
    let(:trail) { stub :trail }

    subject { Crumby::Entry.new(trail, 1, entry_label, entry_route, entry_options) }

    its(:trail) { should equal trail }
    its(:position) { should eq 1 }
    its(:label) { should eq entry_label }
    its(:route) { should eq entry_route }
    its(:options) { should eq entry_options }
  end

  context "on trail with 10 breadcrumb" do
    let(:trail) { trail = stub :trail, count: 10 }

    context "any breadcrumb" do
      subject { Crumby::Entry.new trail, 0, "Test" }
      its(:total) { should eq 10 }
    end

    context "first breadcrumb" do
      subject { Crumby::Entry.new trail, 0, "Test" }
      its(:first?) { should be_true }
      its(:last?) { should_not be_true }
    end

    context "last breadcrumb" do
      subject { Crumby::Entry.new trail, 9, "Test" }
      its(:first?) { should_not be_true }
      its(:last?) { should be_true }
    end

  end

end
