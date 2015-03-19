require "spec_helper"

describe SimpleAssertions do
  describe ".all" do
    let(:all) { SimpleAssertions.all }

    it "returns all autoloaded modules except VERSION" do
      refute all.empty?
      refute_includes all, SimpleAssertions::VERSION
    end
  end
end
