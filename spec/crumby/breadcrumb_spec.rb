# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Crumby::Breadcrumb do

  context "#new" do
    let(:breadcrumb_label) { "TestLabel" }
    let(:breadcrumb_route) { :test }
    let(:breadcrumb_options) { { test: true } }
    let(:breadcrumbs) { stub :breadcrumbs }

    subject { Crumby::Breadcrumb.new(breadcrumbs, 1, breadcrumb_label, breadcrumb_route, breadcrumb_options) }


    its(:breadcrumbs) { should equal breadcrumbs }
    its(:position) { should eq 1 }
    its(:label) { should eq breadcrumb_label }
    its(:route) { should eq breadcrumb_route }
    its(:options) { should eq breadcrumb_options }
  end


  context "on breadcrumbs with 10 breadcrumb" do
    let(:breadcrumbs) { breadcrumbs = stub :breadcrumbs, count: 10 }

    context "any breadcrumb" do
      subject { Crumby::Breadcrumb.new breadcrumbs, 0, "Test" }
      its(:total) { should eq 10 }
    end

    context "first breadcrumb" do
      subject { Crumby::Breadcrumb.new breadcrumbs, 0, "Test" }
      its(:first?) { should be_true }
    end

    context "last breadcrumb" do
      subject { Crumby::Breadcrumb.new breadcrumbs, 9, "Test" }
      its(:last?) { should be_true }
    end

  end



end
