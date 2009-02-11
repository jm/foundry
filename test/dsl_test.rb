require 'test_helper'

class DslTest < Test::Unit::TestCase
  include FoundryHelper

  # Replace this with your real tests.
  context "The DSL" do
    before do
      @runner = Foundry::Runner.new
    end

    it "should scope factory definitions to a model" do
      @runner.model Record do
        factory :da_factory, :title => "AWESOME."
      end

      assert Record.respond_to?(:da_factory)
    end

    it "should create factory scopes" do
      @runner.model Record do
        factory :your_factory, :title => "AWESOME."
      end

      assert Record.respond_to?(:your_factory)
    end

    it "should create factory scopes using the default name if one is not given" do
      @runner.model Record do
        factory do
          {:title => "AWESOME."}
        end
      end

      assert Record.respond_to?(:valid)
    end

    it "should accept a Hash definition" do
      @runner.model Record do
        factory :factoree, :title => "AWESOME."
      end

      assert Record.respond_to?(:factoree)
      assert_equal "AWESOME.", Record.factoree.new.title
    end

    it "should accept a block definition" do
      @runner.model Record do
        factory :blked do
          {:title => "w00t"}
        end
      end

      assert Record.respond_to?(:blked)
      assert_equal "w00t", Record.blked.new.title
    end

    it "should allow extra attributes" do
      @runner.model Record do
        factory :epic, :title => "EPIC FAIL"
      end

      assert_equal "EPIC WIN", Record.epic.with(:title => "EPIC WIN").new.title
    end

    after do
      # Clear Record of any added named scopes from the previously run test.
      Record.scopes.each_key do |name|
        unless [:scoped, :with].include? name
          (class << Record; self end).instance_eval do
            remove_method name
          end

          # Remove scope definition from +scopes+.
          Record.scopes.delete name
        end
      end
    end
  end
end
