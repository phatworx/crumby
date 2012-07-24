require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

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

  context "add a new crumby item" do
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
  end

  context "returns page title" do
    it "test"
  end
  context "return a list" do
    it "test"
  end

end
