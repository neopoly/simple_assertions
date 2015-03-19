require "helper"

class SimpleAssertionsTest < Spec
  context :all do
    let(:all) { SimpleAssertions.all }

    test "returns all autoloaded modules except VERSION" do
      refute all.empty?
      refute all.include?(SimpleAssertions::VERSION)
    end
  end
end
