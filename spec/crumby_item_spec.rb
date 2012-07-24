require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Crumby::Item do
  context "new item" do
    let(:item_label) { "TestLabel" }
    let(:item_route) { :test }
    let(:item_options) { { test: true } }
    let(:item) { Crumby::Item.new(item_label, item_route, item_options) }

    it "present a label" do
      item.label.should == item_label
    end
    it "present a route" do
      item.route.should == item_route
    end
    it "present options" do
      item.options.should == item_options
    end

  end

end
