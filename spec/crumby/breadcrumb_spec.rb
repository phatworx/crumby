# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Crumby::Breadcrumb do
  describe "#new" do

    let(:breadcrumb_label) { "TestLabel" }
    let(:breadcrumb_route) { :test }
    let(:breadcrumb_options) { { test: true } }

    subject { Crumby::Breadcrumb.new(breadcrumb_label, breadcrumb_route, breadcrumb_options) }

    its(:label) { should eq breadcrumb_label }
    its(:route) { should eq breadcrumb_route }
    its(:options) { should eq breadcrumb_options }
  end

end
