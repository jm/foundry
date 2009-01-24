require 'test_helper'

class FoundryTest < Test::Unit::TestCase
  include FoundryHelper

  # Replace this with your real tests.
  context "A foundry" do
    it "should create a named scope" do
      Foundry.factory(Record, :valid_record, :title => "what what")
      assert Record.respond_to?(:valid_record)
    end

    it "should create a scope using the default name if one is not given" do
      Foundry.factory(Record) { {:title => "whattttt"} }
      assert Record.respond_to?(:valid)
    end

    it "should create a scope with a block" do
      Foundry.factory(Record, :blocked_name) do
        {:title => "epic"}
      end

      assert Record.respond_to?(:blocked_name)
    end

    it "should create a scope with a Hash definition" do
      Foundry.factory(Record, :valid_name, :things => "funnnnn")

      assert Record.respond_to?(:valid_name)
    end

    it "should create a scope with a block that takes args" do
      Foundry.factory(Record, :my_factory) do |one, two|
        {:conditions => {:title => "#{one} #{two}"}}
      end

      assert Record.respond_to?(:my_factory)
    end

    context "when making" do
      it "should fill the values correctly from a Hash" do
        Foundry.factory(Record, :so_valid, :title => "hello")
        assert_equal "hello", Record.so_valid.new.title
      end

      it "should fill the value in correctly from a block" do
        Foundry.factory(Record, :w00t) do
          {:conditions => {:title => "m00g"}}
        end

        assert_equal "m00g", Record.w00t.new.title
      end

      it "should handle a block with args" do
        Foundry.factory(Record, :with_title) do |one|
          {:conditions => {:title => "blah #{one}"}}
        end

        assert_equal "blah hoo", Record.with_title("hoo").new.title
      end
    end
  end
end
